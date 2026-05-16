import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

enum ProfileStatus { initial, loading, loaded, updating, updated, error, signedOut, deleting, deleted }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserEntity? user,
    String? errorMessage,
    bool clearError = false,
  }) =>
      ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      );

  @override
  List<Object?> get props => [status, user, errorMessage];
}
