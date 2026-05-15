import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object?> get props => [];
}

class ChangePasswordSubmitEvent extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordSubmitEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class ChangePasswordResetEvent extends ChangePasswordEvent {
  const ChangePasswordResetEvent();
}
