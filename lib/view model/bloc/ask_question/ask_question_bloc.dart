import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/session_store.dart';
import '../../../domain/usecases/question/submit_question_usecase.dart';
import '../../../domain/usecases/speaker/get_speakers_usecase.dart';
import '../../../domain/usecases/user/get_current_user_usecase.dart';
import 'ask_question_event.dart';
import 'ask_question_state.dart';

class AskQuestionBloc extends Bloc<AskQuestionEvent, AskQuestionState> {
  final SubmitQuestionUseCase _submitQuestion;
  final GetSpeakersUseCase _getSpeakers;
  final GetCurrentUserUseCase _getCurrentUser;

  AskQuestionBloc({
    required SubmitQuestionUseCase submitQuestion,
    required GetSpeakersUseCase getSpeakers,
    required GetCurrentUserUseCase getCurrentUser,
  })  : _submitQuestion = submitQuestion,
        _getSpeakers = getSpeakers,
        _getCurrentUser = getCurrentUser,
        super(const AskQuestionState()) {
    on<LoadSpeakersForQuestionEvent>(_onLoadSpeakers);
    on<SelectSpeakerEvent>(_onSelectSpeaker);
    on<SubmitQuestionEvent>(_onSubmit);
    on<ResetAskQuestionEvent>(_onReset);
  }

  Future<void> _onLoadSpeakers(
    LoadSpeakersForQuestionEvent event,
    Emitter<AskQuestionState> emit,
  ) async {
    final uid = SessionStore.instance.currentUserId ?? '';
    if (uid.isEmpty) return;

    final userResult = await _getCurrentUser(uid);
    final eventId = userResult.when(
      success: (user) => user.eventId ?? '',
      failure: (_) => '',
    );
    if (eventId.isEmpty) return;

    final result = await _getSpeakers(eventId);
    result.when(
      success: (speakers) => emit(state.copyWith(
        speakerNames: speakers.map((s) => s.name).toList(),
        prefillName: userResult.when(
          success: (user) => user.fullName,
          failure: (_) => '',
        ),
      )),
      failure: (_) {},
    );
  }

  void _onSelectSpeaker(
    SelectSpeakerEvent event,
    Emitter<AskQuestionState> emit,
  ) {
    emit(state.copyWith(
      selectedSpeaker: () => event.speaker,
      speakerError: () => null,
    ));
  }

  Future<void> _onSubmit(
    SubmitQuestionEvent event,
    Emitter<AskQuestionState> emit,
  ) async {
    final name = event.name.trim();
    final question = event.question.trim();

    final nameErr = name.isEmpty
        ? 'Please enter your name'
        : name.length < 3
            ? 'Name must be at least 3 characters'
            : null;
    final qErr = question.isEmpty
        ? 'Please enter your question'
        : question.length < 10
            ? 'Question is too short (min 10 characters)'
            : null;
    final spErr =
        state.selectedSpeaker == null ? 'Please select a speaker' : null;

    if (nameErr != null || qErr != null || spErr != null) {
      emit(state.copyWith(
        nameError: () => nameErr,
        questionError: () => qErr,
        speakerError: () => spErr,
      ));
      return;
    }

    emit(state.copyWith(
      status: AskQuestionStatus.submitting,
      nameError: () => null,
      questionError: () => null,
      speakerError: () => null,
    ));

    final result = await _submitQuestion(
      name: event.name.trim(),
      speakerName: state.selectedSpeaker!,
      question: event.question.trim(),
    );

    result.when(
      success: (_) => emit(state.copyWith(status: AskQuestionStatus.submitted)),
      failure: (f) => emit(state.copyWith(
        status: AskQuestionStatus.failure,
        errorMessage: f.message,
      )),
    );
  }

  void _onReset(ResetAskQuestionEvent event, Emitter<AskQuestionState> emit) {
    emit(AskQuestionState(speakerNames: state.speakerNames));
  }
}
