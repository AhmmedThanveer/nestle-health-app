import 'package:equatable/equatable.dart';

enum AskQuestionStatus { initial, submitting, submitted, failure }

class AskQuestionState extends Equatable {
  final String? selectedSpeaker;
  final AskQuestionStatus status;
  final List<String> speakerNames;
  final String? errorMessage;
  final String? nameError;
  final String? questionError;
  final String? speakerError;
  final String prefillName;

  const AskQuestionState({
    this.selectedSpeaker,
    this.status = AskQuestionStatus.initial,
    this.speakerNames = const [],
    this.errorMessage,
    this.nameError,
    this.questionError,
    this.speakerError,
    this.prefillName = '',
  });

  AskQuestionState copyWith({
    String? Function()? selectedSpeaker,
    AskQuestionStatus? status,
    List<String>? speakerNames,
    String? errorMessage,
    String? Function()? nameError,
    String? Function()? questionError,
    String? Function()? speakerError,
    String? prefillName,
  }) =>
      AskQuestionState(
        selectedSpeaker:
            selectedSpeaker != null ? selectedSpeaker() : this.selectedSpeaker,
        status: status ?? this.status,
        speakerNames: speakerNames ?? this.speakerNames,
        errorMessage: errorMessage ?? this.errorMessage,
        nameError: nameError != null ? nameError() : this.nameError,
        questionError:
            questionError != null ? questionError() : this.questionError,
        speakerError: speakerError != null ? speakerError() : this.speakerError,
        prefillName: prefillName ?? this.prefillName,
      );

  @override
  List<Object?> get props => [
        selectedSpeaker,
        status,
        speakerNames,
        errorMessage,
        nameError,
        questionError,
        speakerError,
        prefillName,
      ];
}
