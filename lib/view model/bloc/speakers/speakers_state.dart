import 'package:equatable/equatable.dart';

import '../../../core/models/speaker_models.dart';

enum SpeakersStatus { initial, loading, loaded, error }

class SpeakersState extends Equatable {
  final SpeakersStatus status;
  final List<Speaker> allSpeakers;
  final SpeakerCategory selectedCategory;
  final String? errorMessage;

  const SpeakersState({
    this.status = SpeakersStatus.initial,
    this.allSpeakers = const [],
    this.selectedCategory = SpeakerCategory.chairpersons,
    this.errorMessage,
  });

  List<Speaker> get speakers =>
      allSpeakers.where((s) => s.category == selectedCategory).toList();

  SpeakersState copyWith({
    SpeakersStatus? status,
    List<Speaker>? allSpeakers,
    SpeakerCategory? selectedCategory,
    String? errorMessage,
  }) =>
      SpeakersState(
        status: status ?? this.status,
        allSpeakers: allSpeakers ?? this.allSpeakers,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props =>
      [status, allSpeakers, selectedCategory, errorMessage];
}
