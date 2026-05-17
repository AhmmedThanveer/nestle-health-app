import 'package:equatable/equatable.dart';

abstract class AskQuestionEvent extends Equatable {
  const AskQuestionEvent();
}

class LoadSpeakersForQuestionEvent extends AskQuestionEvent {
  const LoadSpeakersForQuestionEvent();

  @override
  List<Object> get props => [];
}

class SelectSpeakerEvent extends AskQuestionEvent {
  final String? speaker;

  const SelectSpeakerEvent(this.speaker);

  @override
  List<Object?> get props => [speaker];
}

class SubmitQuestionEvent extends AskQuestionEvent {
  final String name;
  final String question;

  const SubmitQuestionEvent({required this.name, required this.question});

  @override
  List<Object> get props => [name, question];
}

class ResetAskQuestionEvent extends AskQuestionEvent {
  const ResetAskQuestionEvent();

  @override
  List<Object> get props => [];
}
