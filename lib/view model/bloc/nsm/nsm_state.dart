import 'package:equatable/equatable.dart';

import '../../../domain/entities/nsm_entity.dart';

abstract class NsmState extends Equatable {
  const NsmState();
}

class NsmLoadingState extends NsmState {
  const NsmLoadingState();
  @override
  List<Object> get props => [];
}

class NsmLoadedState extends NsmState {
  final List<NsmDayEntity> days;
  const NsmLoadedState({required this.days});
  @override
  List<Object> get props => [days];
}

class NsmErrorState extends NsmState {
  final String message;
  const NsmErrorState(this.message);
  @override
  List<Object> get props => [message];
}
