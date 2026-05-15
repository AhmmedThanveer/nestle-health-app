import 'package:equatable/equatable.dart';

abstract class SurveyEvent extends Equatable {
  const SurveyEvent();
  @override
  List<Object?> get props => [];
}

class UpdateAnswerEvent extends SurveyEvent {
  final String questionId;
  final String answer;
  const UpdateAnswerEvent(this.questionId, this.answer);
  @override
  List<Object?> get props => [questionId, answer];
}

class SubmitSurveyEvent extends SurveyEvent {
  final String userId;
  final String eventId;
  const SubmitSurveyEvent({required this.userId, required this.eventId});
  @override
  List<Object?> get props => [userId, eventId];
}
