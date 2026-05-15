import 'package:equatable/equatable.dart';

import '../../../core/models/asset_models.dart';

abstract class AssetsState extends Equatable {
  const AssetsState();
}

class AssetsInitialState extends AssetsState {
  const AssetsInitialState();

  @override
  List<Object> get props => [];
}

class AssetsLoadedState extends AssetsState {
  final List<AssetFolder> folders;

  const AssetsLoadedState(this.folders);

  @override
  List<Object> get props => [folders];
}
