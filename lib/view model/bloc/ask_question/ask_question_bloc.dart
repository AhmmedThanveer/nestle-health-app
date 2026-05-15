import 'package:flutter_bloc/flutter_bloc.dart';

import 'ask_question_event.dart';
import 'ask_question_state.dart';

class AskQuestionBloc extends Bloc<AskQuestionEvent, AskQuestionState> {
  AskQuestionBloc() : super(const AskQuestionState()) {
    on<SelectSpeakerEvent>(_onSelectSpeaker);
    on<SubmitQuestionEvent>(_onSubmit);
    on<ResetAskQuestionEvent>(_onReset);
  }

  void _onSelectSpeaker(SelectSpeakerEvent event, Emitter<AskQuestionState> emit) {
    emit(state.copyWith(selectedSpeaker: () => event.speaker));
  }

  Future<void> _onSubmit(SubmitQuestionEvent event, Emitter<AskQuestionState> emit) async {
    if (event.name.trim().isEmpty || event.question.trim().isEmpty) return;
    emit(state.copyWith(status: AskQuestionStatus.submitting));
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: AskQuestionStatus.submitted));
  }

  void _onReset(ResetAskQuestionEvent event, Emitter<AskQuestionState> emit) {
    emit(const AskQuestionState());
  }
}
