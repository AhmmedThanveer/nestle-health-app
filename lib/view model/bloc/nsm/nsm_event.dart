import 'package:equatable/equatable.dart';

abstract class NsmEvent extends Equatable {
  const NsmEvent();
}

class LoadNsmEvent extends NsmEvent {
  const LoadNsmEvent();

  @override
  List<Object> get props => [];
}
