import 'package:equatable/equatable.dart';

abstract class AssetsEvent extends Equatable {
  const AssetsEvent();
}

class LoadAssetsEvent extends AssetsEvent {
  const LoadAssetsEvent();

  @override
  List<Object> get props => [];
}
