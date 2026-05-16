import 'package:equatable/equatable.dart';

import '../../../core/models/media_models.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();
}

class LoadMediaEvent extends MediaEvent {
  const LoadMediaEvent();

  @override
  List<Object> get props => [];
}

class SelectMediaTypeEvent extends MediaEvent {
  final MediaType type;

  const SelectMediaTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}
