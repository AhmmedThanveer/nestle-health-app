import 'package:equatable/equatable.dart';

import '../../../core/models/media_models.dart';

class MediaState extends Equatable {
  final MediaType selectedType;

  const MediaState({this.selectedType = MediaType.photo});

  List<MediaItem> get items => MediaData.byType(selectedType);

  MediaState copyWith({MediaType? selectedType}) =>
      MediaState(selectedType: selectedType ?? this.selectedType);

  @override
  List<Object> get props => [selectedType];
}
