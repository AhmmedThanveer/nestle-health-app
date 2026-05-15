import 'package:equatable/equatable.dart';

import '../../../core/models/speaker_models.dart';

abstract class SpeakersEvent extends Equatable {
  const SpeakersEvent();
  @override
  List<Object?> get props => [];
}

class LoadSpeakersEvent extends SpeakersEvent {
  final String eventId;
  const LoadSpeakersEvent(this.eventId);
  @override
  List<Object?> get props => [eventId];
}

class SelectSpeakerCategoryEvent extends SpeakersEvent {
  final SpeakerCategory category;
  const SelectSpeakerCategoryEvent(this.category);
  @override
  List<Object?> get props => [category];
}
