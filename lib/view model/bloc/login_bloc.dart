import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/di/service_locator.dart';
import '../../core/utils/session_store.dart';
import '../../domain/usecases/auth/forgot_password_usecase.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../services/analytics_service.dart';
import '../../services/crashlytics_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final AnalyticsService _analytics;
  final CrashlyticsService _crashlytics;

  LoginBloc()
      : _loginUseCase = sl<LoginUseCase>(),
        _forgotPasswordUseCase = sl<ForgotPasswordUseCase>(),
        _analytics = sl<AnalyticsService>(),
        _crashlytics = sl<CrashlyticsService>(),
        super(const LoginState()) {
    on<TogglePasswordVisibilityEvent>(_onTogglePassword);
    on<LoginButtonPressedEvent>(_onLoginPressed);
    on<SendPasswordResetEvent>(_onSendPasswordReset);
  }

  void _onTogglePassword(
    TogglePasswordVisibilityEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onLoginPressed(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter your email and password.'));
      return;
    }

    emit(state.copyWith(isLoading: true, isLoginSuccess: false, clearError: true));

    final result = await _loginUseCase(
      email: event.email.trim(),
      password: event.password.trim(),
    );

    result.when(
      success: (user) {
        SessionStore.instance.currentUserId = user.uid;
        _analytics.logLogin();
        _analytics.setUserId(user.uid);
        _crashlytics.setUserIdentifier(user.uid);
        emit(state.copyWith(isLoading: false, isLoginSuccess: true));
      },
      failure: (f) {
        _crashlytics.log('Login failed: ${f.message}');
        emit(state.copyWith(isLoading: false, errorMessage: f.message));
      },
    );
  }

  Future<void> _onSendPasswordReset(
    SendPasswordResetEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (event.email.trim().isEmpty) {
      emit(state.copyWith(passwordResetError: 'Please enter your email address.'));
      return;
    }

    emit(state.copyWith(
      isPasswordResetLoading: true,
      isPasswordResetSent: false,
      clearPasswordResetError: true,
    ));

    final result = await _forgotPasswordUseCase(email: event.email.trim());

    result.when(
      success: (_) {
        emit(state.copyWith(
          isPasswordResetLoading: false,
          isPasswordResetSent: true,
        ));
      },
      failure: (f) {
        emit(state.copyWith(
          isPasswordResetLoading: false,
          passwordResetError: f.message,
        ));
      },
    );
  }
}
