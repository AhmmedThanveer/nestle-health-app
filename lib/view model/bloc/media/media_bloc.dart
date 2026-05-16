import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../core/models/media_models.dart';
import 'media_event.dart';
import 'media_state.dart';

export 'media_event.dart';
export 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final FirebaseFirestore _db;

  MediaBloc()
      : _db = sl<FirebaseFirestore>(),
        super(const MediaState()) {
    on<LoadMediaEvent>(_onLoad);
    on<SelectMediaTypeEvent>(_onSelectType);
  }

  Future<void> _onLoad(LoadMediaEvent event, Emitter<MediaState> emit) async {
    emit(state.copyWith(status: MediaStatus.loading, clearError: true));
    try {
      final snap = await _db.collection('media').get();

      if (snap.docs.isEmpty) {
        emit(state.copyWith(status: MediaStatus.empty, allItems: []));
        return;
      }

      final items = snap.docs
          .map((doc) => MediaItem.fromFirestore(doc.id, doc.data()))
          .toList();

      emit(state.copyWith(status: MediaStatus.loaded, allItems: items));
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        emit(state.copyWith(status: MediaStatus.noInternet));
      } else {
        emit(state.copyWith(
          status: MediaStatus.serverError,
          errorMessage: e.message,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: MediaStatus.noInternet));
    }
  }

  void _onSelectType(SelectMediaTypeEvent event, Emitter<MediaState> emit) {
    if (event.type != state.selectedType) {
      emit(state.copyWith(selectedType: event.type));
    }
  }
}
