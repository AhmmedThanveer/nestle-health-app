import 'package:equatable/equatable.dart';

abstract class VotingEvent extends Equatable {
  const VotingEvent();

  @override
  List<Object?> get props => [];
}

class LoadActivePollEvent extends VotingEvent {
  const LoadActivePollEvent();
}

class SubmitVoteEvent extends VotingEvent {
  final String pollId;
  final String selectedOption;

  const SubmitVoteEvent({required this.pollId, required this.selectedOption});

  @override
  List<Object?> get props => [pollId, selectedOption];
}

class SelectOptionEvent extends VotingEvent {
  final String option;

  const SelectOptionEvent(this.option);

  @override
  List<Object?> get props => [option];
}
