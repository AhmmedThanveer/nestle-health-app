import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/remote/agenda_remote_datasource.dart';
import '../../data/datasources/remote/auth_remote_datasource.dart';
import '../../data/datasources/remote/event_remote_datasource.dart';
import '../../data/datasources/remote/notification_remote_datasource.dart';
import '../../data/datasources/remote/nsm_remote_datasource.dart';
import '../../data/datasources/remote/speaker_remote_datasource.dart';
import '../../data/datasources/remote/station_remote_datasource.dart';
import '../../data/datasources/remote/user_remote_datasource.dart';
import '../../data/datasources/remote/survey_remote_datasource.dart';
import '../../data/repositories/agenda_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/survey_repository_impl.dart';
import '../../data/repositories/event_repository_impl.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../data/repositories/nsm_repository_impl.dart';
import '../../data/repositories/speaker_repository_impl.dart';
import '../../data/repositories/station_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/agenda_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/event_repository.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/repositories/nsm_repository.dart';
import '../../domain/repositories/speaker_repository.dart';
import '../../domain/repositories/station_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/agenda/get_agenda_usecase.dart';
import '../../domain/usecases/auth/change_password_usecase.dart';
import '../../domain/usecases/auth/forgot_password_usecase.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/sign_out_usecase.dart';
import '../../domain/usecases/event/validate_event_code_usecase.dart';
import '../../domain/repositories/survey_repository.dart';
import '../../domain/usecases/notification/watch_notifications_usecase.dart';
import '../../domain/usecases/nsm/get_nsm_days_usecase.dart';
import '../../domain/usecases/speaker/get_speakers_usecase.dart';
import '../../domain/usecases/station/award_station_points_usecase.dart';
import '../../domain/usecases/station/load_stations_usecase.dart';
import '../../domain/usecases/survey/submit_survey_usecase.dart';
import '../../domain/usecases/user/get_current_user_usecase.dart';
import '../../domain/usecases/user/update_profile_usecase.dart';
import '../../services/analytics_service.dart';
import '../../services/crashlytics_service.dart';
import '../../services/fcm_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Firebase instances ────────────────────────────────────────────────────
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
  sl.registerLazySingleton<FirebaseAnalytics>(
      () => FirebaseAnalytics.instance);
  sl.registerLazySingleton<FirebaseCrashlytics>(
      () => FirebaseCrashlytics.instance);

  // ── Services ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<FCMService>(() => FCMService(sl()));
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsService(sl()));
  sl.registerLazySingleton<CrashlyticsService>(
      () => CrashlyticsService(sl()));

  // ── Data Sources ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(sl()));

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: sl(),
      userDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(sl()));
  sl.registerLazySingleton<SpeakerRemoteDataSource>(
      () => SpeakerRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<SpeakerRepository>(
      () => SpeakerRepositoryImpl(sl()));
  sl.registerLazySingleton<AgendaRemoteDataSource>(
      () => AgendaRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AgendaRepository>(
      () => AgendaRepositoryImpl(sl()));
  sl.registerLazySingleton<StationRemoteDataSource>(
      () => StationRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<StationRepository>(
      () => StationRepositoryImpl(sl()));
  sl.registerLazySingleton<NsmRemoteDataSource>(
      () => NsmRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<NsmRepository>(
      () => NsmRepositoryImpl(sl()));

  // ── Use Cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ValidateEventCodeUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => WatchNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => GetSpeakersUseCase(sl()));
  sl.registerLazySingleton(() => GetAgendaUseCase(sl()));
  sl.registerLazySingleton<SurveyRemoteDataSource>(
      () => SurveyRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<SurveyRepository>(
      () => SurveyRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SubmitSurveyUseCase(sl()));
  sl.registerLazySingleton(() => LoadStationsUseCase(sl()));
  sl.registerLazySingleton(() => AwardStationPointsUseCase(sl()));
  sl.registerLazySingleton(() => GetNsmDaysUseCase(sl()));
}
