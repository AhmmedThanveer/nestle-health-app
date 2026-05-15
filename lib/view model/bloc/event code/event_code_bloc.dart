import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';

import 'event_code_event.dart';
import 'event_code_state.dart';

class EventCodeBloc extends Bloc<EventCodeEvent, EventCodeState> {
  EventCodeBloc() : super(const EventCodeState()) {
    on<ValidateEventCodeEvent>(_validateEventCode);
  }

  void _validateEventCode(
    ValidateEventCodeEvent event,
    Emitter<EventCodeState> emit,
  ) {
    final code = event.code.trim();

    /// EMPTY VALIDATION
    if (code.isEmpty) {
      emit(
        state.copyWith(
          isSuccess: false,

          errorMessage: AppStrings.eventCodeRequired,
        ),
      );

      return;
    }

    /// SUCCESS VALIDATION
    if (code.toUpperCase() == AppStrings.validEventCode) {
      emit(state.copyWith(isSuccess: true, errorMessage: null));
    } else {
      /// INVALID CODE
      emit(
        state.copyWith(
          isSuccess: false,

          errorMessage: AppStrings.invalidEventCode,
        ),
      );
    }
  }
}
