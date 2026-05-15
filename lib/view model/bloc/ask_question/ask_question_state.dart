import 'package:equatable/equatable.dart';

enum AskQuestionStatus { initial, submitting, submitted, failure }

class AskQuestionState extends Equatable {
  final String? selectedSpeaker;
  final AskQuestionStatus status;

  const AskQuestionState({
    this.selectedSpeaker,
    this.status = AskQuestionStatus.initial,
  });

  AskQuestionState copyWith({
    String? Function()? selectedSpeaker,
    AskQuestionStatus? status,
  }) => AskQuestionState(
    selectedSpeaker:
        selectedSpeaker != null ? selectedSpeaker() : this.selectedSpeaker,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [selectedSpeaker, status];
}
