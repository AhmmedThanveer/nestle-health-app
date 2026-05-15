import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/session_store.dart';
import '../../../domain/usecases/event/validate_event_code_usecase.dart';
import 'event_code_event.dart';
import 'event_code_state.dart';

class EventCodeBloc extends Bloc<EventCodeEvent, EventCodeState> {
  final ValidateEventCodeUseCase _validateUseCase;

  EventCodeBloc()
      : _validateUseCase = sl<ValidateEventCodeUseCase>(),
        super(const EventCodeState()) {
    on<ValidateEventCodeEvent>(_onValidate);
  }

  Future<void> _onValidate(
    ValidateEventCodeEvent event,
    Emitter<EventCodeState> emit,
  ) async {
    final code = event.code.trim();

    if (code.isEmpty) {
      emit(state.copyWith(
        isSuccess: false,
        errorMessage: AppStrings.eventCodeRequired,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      clearError: true,
    ));

    final result = await _validateUseCase(code);

    result.when(
      success: (eventEntity) {
        // Store the validated event id so RegisterBloc can read it.
        SessionStore.instance.pendingEventId = eventEntity.id;
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          validatedEventId: eventEntity.id,
        ));
      },
      failure: (f) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: f.message,
        ));
      },
    );
  }
}
