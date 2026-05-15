import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool obscurePassword;
  final bool isLoading;
  final bool isLoginSuccess;
  final String? errorMessage;

  // Forgot-password sub-state (reused on the ForgotPasswordScreen)
  final bool isPasswordResetLoading;
  final bool isPasswordResetSent;
  final String? passwordResetError;

  const LoginState({
    this.obscurePassword = true,
    this.isLoading = false,
    this.isLoginSuccess = false,
    this.errorMessage,
    this.isPasswordResetLoading = false,
    this.isPasswordResetSent = false,
    this.passwordResetError,
  });

  LoginState copyWith({
    bool? obscurePassword,
    bool? isLoading,
    bool? isLoginSuccess,
    String? errorMessage,
    bool clearError = false,
    bool? isPasswordResetLoading,
    bool? isPasswordResetSent,
    String? passwordResetError,
    bool clearPasswordResetError = false,
  }) =>
      LoginState(
        obscurePassword: obscurePassword ?? this.obscurePassword,
        isLoading: isLoading ?? this.isLoading,
        isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
        errorMessage:
            clearError ? null : (errorMessage ?? this.errorMessage),
        isPasswordResetLoading:
            isPasswordResetLoading ?? this.isPasswordResetLoading,
        isPasswordResetSent:
            isPasswordResetSent ?? this.isPasswordResetSent,
        passwordResetError: clearPasswordResetError
            ? null
            : (passwordResetError ?? this.passwordResetError),
      );

  @override
  List<Object?> get props => [
        obscurePassword,
        isLoading,
        isLoginSuccess,
        errorMessage,
        isPasswordResetLoading,
        isPasswordResetSent,
        passwordResetError,
      ];
}
