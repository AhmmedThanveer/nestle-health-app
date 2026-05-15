import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TogglePasswordVisibilityEvent extends LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
