import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched once when HomeScreen mounts. After a short frame-settle delay
/// the bloc emits [HomeState.isLoaded = true], which drives all entrance
/// animations via implicit animated widgets in the UI layer.
class HomeLoadEvent extends HomeEvent {
  const HomeLoadEvent();
}
