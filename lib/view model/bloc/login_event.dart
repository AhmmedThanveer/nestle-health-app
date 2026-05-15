import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class TogglePasswordVisibilityEvent extends LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SendPasswordResetEvent extends LoginEvent {
  final String email;
  const SendPasswordResetEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
