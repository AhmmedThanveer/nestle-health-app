import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/survey/submit_survey_usecase.dart';
import 'survey_event.dart';
import 'survey_state.dart';

export 'survey_event.dart';
export 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SubmitSurveyUseCase _submit;

  SurveyBloc()
      : _submit = sl<SubmitSurveyUseCase>(),
        super(const SurveyState()) {
    on<UpdateAnswerEvent>(_onUpdate);
    on<SubmitSurveyEvent>(_onSubmit);
  }

  void _onUpdate(UpdateAnswerEvent event, Emitter<SurveyState> emit) {
    final updated = Map<String, String>.from(state.answers);
    updated[event.questionId] = event.answer;
    emit(state.copyWith(answers: updated, clearError: true));
  }

  Future<void> _onSubmit(
    SubmitSurveyEvent event,
    Emitter<SurveyState> emit,
  ) async {
    final unanswered = state.unansweredRequiredId();
    if (unanswered != null) {
      emit(state.copyWith(
        status: SurveyStatus.error,
        errorMessage: 'Please answer all required questions.',
      ));
      return;
    }

    emit(state.copyWith(status: SurveyStatus.submitting, clearError: true));
    final result = await _submit(
      userId: event.userId,
      eventId: event.eventId,
      answers: state.answers,
    );
    result.when(
      success: (_) => emit(state.copyWith(status: SurveyStatus.submitted)),
      failure: (f) => emit(state.copyWith(
        status: SurveyStatus.error,
        errorMessage: f.message,
      )),
    );
  }
}
