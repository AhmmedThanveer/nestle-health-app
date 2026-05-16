import 'package:equatable/equatable.dart';

import '../../../core/models/asset_models.dart';

enum AssetsStatus { initial, loading, loaded, empty, noInternet, serverError }

class AssetsState extends Equatable {
  final AssetsStatus status;
  final List<AssetFolder> folders;
  final String? errorMessage;

  const AssetsState({
    this.status = AssetsStatus.initial,
    this.folders = const [],
    this.errorMessage,
  });

  AssetsState copyWith({
    AssetsStatus? status,
    List<AssetFolder>? folders,
    String? errorMessage,
    bool clearError = false,
  }) =>
      AssetsState(
        status: status ?? this.status,
        folders: folders ?? this.folders,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  List<Object?> get props => [status, folders, errorMessage];
}
