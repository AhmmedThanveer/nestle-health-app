import 'package:equatable/equatable.dart';

import '../../../core/models/media_models.dart';

enum MediaStatus { initial, loading, loaded, empty, noInternet, serverError }

class MediaState extends Equatable {
  final MediaStatus status;
  final MediaType selectedType;
  final List<MediaItem> allItems;
  final String? errorMessage;

  const MediaState({
    this.status = MediaStatus.initial,
    this.selectedType = MediaType.photo,
    this.allItems = const [],
    this.errorMessage,
  });

  List<MediaItem> get items =>
      allItems.where((m) => m.type == selectedType).toList();

  MediaState copyWith({
    MediaStatus? status,
    MediaType? selectedType,
    List<MediaItem>? allItems,
    String? errorMessage,
    bool clearError = false,
  }) =>
      MediaState(
        status: status ?? this.status,
        selectedType: selectedType ?? this.selectedType,
        allItems: allItems ?? this.allItems,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  List<Object?> get props => [status, selectedType, allItems, errorMessage];
}
