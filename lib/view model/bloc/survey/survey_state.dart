import 'package:equatable/equatable.dart';

import '../../../core/models/survey_models.dart';

enum SurveyStatus { initial, submitting, submitted, error }

class SurveyState extends Equatable {
  final SurveyStatus status;
  final Map<String, String> answers;
  final String? errorMessage;

  const SurveyState({
    this.status = SurveyStatus.initial,
    this.answers = const {},
    this.errorMessage,
  });

  static const List<SurveyQuestion> questions = [
    SurveyQuestion(
      id: 'overall_experience',
      text:
          'How would you rate your overall experience at the Nestlé Congress?',
      type: QuestionType.radio,
      options: ['Poor', 'Average', 'Good', 'Excellent', 'Outstanding'],
    ),
    SurveyQuestion(
      id: 'content_quality',
      text:
          'How would you rate the overall quality of the scientific content presented?',
      type: QuestionType.radio,
      options: ['Poor', 'Average', 'Good', 'Excellent', 'Outstanding'],
    ),
    SurveyQuestion(
      id: 'organization',
      text:
          'How would you rate the organization and logistics of the event?',
      type: QuestionType.radio,
      options: ['Poor', 'Average', 'Good', 'Excellent', 'Outstanding'],
    ),
    SurveyQuestion(
      id: 'improvement_area',
      text: 'What is one specific area we could improve next time?',
      type: QuestionType.text,
    ),
    SurveyQuestion(
      id: 'factory_feedback',
      text:
          'In case you visited “Nestlé Saudi Manufacturing” during the Congress, what is your feedback on the factory (Premises, Quality standards, and Safety)?',
      type: QuestionType.text,
    ),
  ];

  String? unansweredRequiredId() {
    for (final q in questions) {
      if (q.isRequired && (answers[q.id] ?? '').trim().isEmpty) return q.id;
    }
    return null;
  }

  SurveyState copyWith({
    SurveyStatus? status,
    Map<String, String>? answers,
    String? errorMessage,
    bool clearError = false,
  }) =>
      SurveyState(
        status: status ?? this.status,
        answers: answers ?? this.answers,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  List<Object?> get props => [status, answers, errorMessage];
}
