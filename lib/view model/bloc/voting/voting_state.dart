import 'package:equatable/equatable.dart';

enum VotingStatus { initial, loading, active, empty, noInternet, serverError, submitting, voted }

class PollOption extends Equatable {
  final String text;
  final int votes;

  const PollOption({required this.text, required this.votes});

  @override
  List<Object?> get props => [text, votes];
}

class ActivePoll extends Equatable {
  final String id;
  final String question;
  final List<PollOption> options;
  final int totalVotes;

  const ActivePoll({
    required this.id,
    required this.question,
    required this.options,
    required this.totalVotes,
  });

  @override
  List<Object?> get props => [id, question, options, totalVotes];
}

class VotingState extends Equatable {
  final VotingStatus status;
  final ActivePoll? poll;
  final String? selectedOption;
  final String? errorMessage;

  const VotingState({
    this.status = VotingStatus.initial,
    this.poll,
    this.selectedOption,
    this.errorMessage,
  });

  VotingState copyWith({
    VotingStatus? status,
    ActivePoll? poll,
    String? selectedOption,
    String? errorMessage,
    bool clearPoll = false,
    bool clearSelected = false,
    bool clearError = false,
  }) =>
      VotingState(
        status: status ?? this.status,
        poll: clearPoll ? null : (poll ?? this.poll),
        selectedOption: clearSelected ? null : (selectedOption ?? this.selectedOption),
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  List<Object?> get props => [status, poll, selectedOption, errorMessage];
}
