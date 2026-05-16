import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import 'voting_event.dart';
import 'voting_state.dart';

export 'voting_event.dart';
export 'voting_state.dart';

class VotingBloc extends Bloc<VotingEvent, VotingState> {
  final FirebaseFirestore _db;

  VotingBloc()
      : _db = sl<FirebaseFirestore>(),
        super(const VotingState()) {
    on<LoadActivePollEvent>(_onLoad);
    on<SelectOptionEvent>(_onSelectOption);
    on<SubmitVoteEvent>(_onSubmit);
  }

  Future<void> _onLoad(
    LoadActivePollEvent event,
    Emitter<VotingState> emit,
  ) async {
    emit(state.copyWith(status: VotingStatus.loading, clearError: true));
    try {
      final snap = await _db
          .collection('polls')
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();

      if (snap.docs.isEmpty) {
        emit(state.copyWith(status: VotingStatus.empty, clearPoll: true));
        return;
      }

      final doc = snap.docs.first;
      final data = doc.data();

      final question = data['question'] as String? ?? '';
      final rawList = (data['options'] as List? ?? []);
      final rawOptions = rawList
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      final options = rawOptions
          .map((o) => PollOption(
                text: (o['text'] as String?) ?? '',
                votes: (o['votes'] as num?)?.toInt() ?? 0,
              ))
          .where((o) => o.text.isNotEmpty)
          .toList();

      if (question.isEmpty || options.isEmpty) {
        emit(state.copyWith(status: VotingStatus.empty, clearPoll: true));
        return;
      }

      final totalVotes = options.fold<int>(0, (acc, o) => acc + o.votes);

      emit(state.copyWith(
        status: VotingStatus.active,
        poll: ActivePoll(
          id: doc.id,
          question: question,
          options: options,
          totalVotes: totalVotes,
        ),
        clearSelected: true,
      ));
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        emit(state.copyWith(status: VotingStatus.noInternet));
      } else {
        emit(state.copyWith(
          status: VotingStatus.serverError,
          errorMessage: e.message,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: VotingStatus.noInternet));
    }
  }

  void _onSelectOption(SelectOptionEvent event, Emitter<VotingState> emit) {
    emit(state.copyWith(selectedOption: event.option));
  }

  Future<void> _onSubmit(
    SubmitVoteEvent event,
    Emitter<VotingState> emit,
  ) async {
    if (state.selectedOption == null) return;
    emit(state.copyWith(status: VotingStatus.submitting));
    try {
      final pollRef = _db.collection('polls').doc(event.pollId);
      await _db.runTransaction((tx) async {
        final snap = await tx.get(pollRef);
        final rawOptions = List<Map<String, dynamic>>.from(
          (snap.data()!['options'] as List)
              .map((e) => Map<String, dynamic>.from(e as Map)),
        );
        final updated = rawOptions.map((o) {
          if (o['text'] == event.selectedOption) {
            return {...o, 'votes': (o['votes'] as num? ?? 0) + 1};
          }
          return o;
        }).toList();
        tx.update(pollRef, {'options': updated});
      });
      emit(state.copyWith(status: VotingStatus.voted));
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        emit(state.copyWith(status: VotingStatus.noInternet));
      } else {
        emit(state.copyWith(
          status: VotingStatus.serverError,
          errorMessage: e.message,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: VotingStatus.noInternet));
    }
  }
}
