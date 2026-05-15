import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import 'cme_event.dart';
import 'cme_state.dart';

export 'cme_event.dart';
export 'cme_state.dart';

class CmeBloc extends Bloc<CmeEvent, CmeState> {
  final FirebaseFirestore _db;

  CmeBloc()
      : _db = sl<FirebaseFirestore>(),
        super(const CmeState()) {
    on<CheckCmeEligibilityEvent>(_onCheck);
  }

  Future<void> _onCheck(
    CheckCmeEligibilityEvent event,
    Emitter<CmeState> emit,
  ) async {
    emit(state.copyWith(status: CmeStatus.loading));
    try {
      final snap = await _db
          .collection('registrations')
          .where('userId', isEqualTo: event.uid)
          .where('attended', isEqualTo: true)
          .limit(1)
          .get();

      if (snap.docs.isEmpty) {
        emit(state.copyWith(status: CmeStatus.notEligible));
      } else {
        final url = snap.docs.first.data()['certificateUrl'] as String?;
        emit(state.copyWith(status: CmeStatus.eligible, certificateUrl: url));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CmeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
