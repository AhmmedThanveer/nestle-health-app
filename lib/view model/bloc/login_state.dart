import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool obscurePassword;
  final bool isLoading;
  final bool isLoginSuccess;

  const LoginState({
    this.obscurePassword = true,
    this.isLoading = false,
    this.isLoginSuccess = false,
  });

  LoginState copyWith({
    bool? obscurePassword,
    bool? isLoading,
    bool? isLoginSuccess,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
    );
  }

  @override
  List<Object?> get props => [obscurePassword, isLoading, isLoginSuccess];
}
