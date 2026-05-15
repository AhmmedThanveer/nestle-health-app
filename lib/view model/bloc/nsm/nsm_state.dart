import 'package:equatable/equatable.dart';

import '../../../core/models/nsm_models.dart';

abstract class NsmState extends Equatable {
  const NsmState();
}

class NsmLoadingState extends NsmState {
  const NsmLoadingState();

  @override
  List<Object> get props => [];
}

class NsmLoadedState extends NsmState {
  final List<NsmDay> days;

  const NsmLoadedState({required this.days});

  @override
  List<Object> get props => [days];
}
