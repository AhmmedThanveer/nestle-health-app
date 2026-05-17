import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../core/utils/session_store.dart';
import '../../../data/datasources/remote/user_remote_datasource.dart';
import '../../../domain/usecases/auth/register_usecase.dart';
import '../../../services/analytics_service.dart';
import '../../../services/crashlytics_service.dart';
import '../../../services/fcm_service.dart';
import 'register_event.dart';
import 'register_state.dart';

export 'register_event.dart';
export 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final AnalyticsService _analytics;
  final CrashlyticsService _crashlytics;

  RegisterBloc()
      : _registerUseCase = sl<RegisterUseCase>(),
        _analytics = sl<AnalyticsService>(),
        _crashlytics = sl<CrashlyticsService>(),
        super(const RegisterState()) {
    on<RegisterButtonPressedEvent>(_onRegisterPressed);
  }

  Future<void> _onRegisterPressed(
    RegisterButtonPressedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    // Retrieve the event id set by EventCodeBloc.
    final eventId = SessionStore.instance.pendingEventId ?? '';
    if (eventId.isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Session expired. Please re-enter your event code.',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, isSuccess: false, clearError: true));

    final params = RegisterParams(
      email: event.email,
      password: event.password,
      firstName: event.firstName,
      familyName: event.familyName,
      mobile: event.mobile,
      profession: event.profession,
      city: event.city,
      workplace: event.placeOfWork,
      saudiCouncilNumber: event.saudiCouncil,
      selectedTopic: event.topic,
      eventId: eventId,
    );

    final result = await _registerUseCase(params);

    result.when(
      success: (user) {
        SessionStore.instance.currentUserId = user.uid;
        _analytics.logSignUp();
        _analytics.setUserId(user.uid);
        _crashlytics.setUserIdentifier(user.uid);
        emit(state.copyWith(isLoading: false, isSuccess: true));
        _saveFcmToken(user.uid);
      },
      failure: (f) {
        _crashlytics.log('Registration failed: ${f.message}');
        emit(state.copyWith(isLoading: false, errorMessage: f.message));
      },
    );
  }

  void _saveFcmToken(String uid) async {
    try {
      final token = await sl<FCMService>().getToken();
      if (token != null) {
        await sl<UserRemoteDataSource>().updateFcmToken(uid: uid, token: token);
      }
    } catch (_) {}
  }
}
