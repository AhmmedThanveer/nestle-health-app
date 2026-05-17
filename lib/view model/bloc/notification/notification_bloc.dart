import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/usecases/notification/watch_notifications_usecase.dart';
import '../../../domain/repositories/notification_repository.dart';
import '../../../services/fcm_service.dart';
import '../../../services/local_notification_service.dart';
import 'notification_event.dart';
import 'notification_state.dart';

export 'notification_event.dart';
export 'notification_state.dart';

class _NotificationsUpdated extends NotificationEvent {
  final List<NotificationEntity> notifications;
  const _NotificationsUpdated(this.notifications);
  @override
  List<Object?> get props => [notifications];
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final WatchNotificationsUseCase _watchNotifications;
  final NotificationRepository _repository;
  final FCMService _fcm;
  final LocalNotificationService _localNotif;

  StreamSubscription? _firestoreSub;
  StreamSubscription? _fcmSub;

  NotificationBloc()
      : _watchNotifications = sl<WatchNotificationsUseCase>(),
        _repository = sl<NotificationRepository>(),
        _fcm = sl<FCMService>(),
        _localNotif = sl<LocalNotificationService>(),
        super(const NotificationState()) {
    on<WatchNotificationsEvent>(_onWatch);
    on<_NotificationsUpdated>(_onUpdated);
    on<MarkAllNotificationsReadEvent>(_onMarkAllRead);
  }

  Future<void> _onWatch(
    WatchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    // Firestore in-app notifications stream.
    await _firestoreSub?.cancel();
    _firestoreSub = _watchNotifications(event.eventId).listen(
      (notifications) {
        if (!isClosed) add(_NotificationsUpdated(notifications));
      },
      onError: (_) {
        // PERMISSION_DENIED after sign-out is expected — suppress.
      },
    );

    // FCM foreground messages — show a local notification banner as a
    // side effect, then also surface the message in the state.
    await _fcmSub?.cancel();
    _fcmSub = _fcm.onForegroundMessage.listen((message) async {
      final title = message.notification?.title ?? '';
      final body = message.notification?.body ?? '';
      if (title.isNotEmpty || body.isNotEmpty) {
        await _localNotif.show(title: title, body: body);
      }
    });
  }

  void _onUpdated(
    _NotificationsUpdated event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(
      status: NotificationStatus.loaded,
      notifications: event.notifications,
      clearError: true,
    ));
  }

  Future<void> _onMarkAllRead(
    MarkAllNotificationsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await _repository.markAllRead(event.eventId);
  }

  @override
  Future<void> close() async {
    await _firestoreSub?.cancel();
    await _fcmSub?.cancel();
    return super.close();
  }
}
