import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../core/utils/session_store.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth/sign_out_usecase.dart';
import '../../../services/analytics_service.dart';
import '../../../services/crashlytics_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final SignOutUseCase _signOutUseCase;
  final AnalyticsService _analytics;
  final CrashlyticsService _crashlytics;

  AuthBloc()
      : _authRepository = sl<AuthRepository>(),
        _signOutUseCase = sl<SignOutUseCase>(),
        _analytics = sl<AnalyticsService>(),
        _crashlytics = sl<CrashlyticsService>(),
        super(AuthInitialState()) {
    on<AppStartedEvent>(_onAppStarted);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onAppStarted(
    AppStartedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await emit.forEach<dynamic>(
      _authRepository.authStateChanges,
      onData: (user) {
        if (user != null) {
          SessionStore.instance.currentUserId = user.uid;
          _analytics.setUserId(user.uid);
          _crashlytics.setUserIdentifier(user.uid);
          return AuthAuthenticatedState(user);
        }
        SessionStore.instance.clear();
        return AuthUnauthenticatedState();
      },
      onError: (_, __) => AuthUnauthenticatedState(),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await _signOutUseCase();
    SessionStore.instance.clear();
    emit(AuthUnauthenticatedState());
  }
}
