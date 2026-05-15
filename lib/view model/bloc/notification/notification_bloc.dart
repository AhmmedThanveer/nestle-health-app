import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/notification/watch_notifications_usecase.dart';
import '../../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

export 'notification_event.dart';
export 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final WatchNotificationsUseCase _watchNotifications;
  final NotificationRepository _repository;

  NotificationBloc()
      : _watchNotifications = sl<WatchNotificationsUseCase>(),
        _repository = sl<NotificationRepository>(),
        super(const NotificationState()) {
    on<WatchNotificationsEvent>(_onWatch);
    on<MarkAllNotificationsReadEvent>(_onMarkAllRead);
  }

  Future<void> _onWatch(
    WatchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    await emit.forEach(
      _watchNotifications(event.eventId),
      onData: (notifications) => state.copyWith(
        status: NotificationStatus.loaded,
        notifications: notifications,
        clearError: true,
      ),
      onError: (e, _) => state.copyWith(
        status: NotificationStatus.error,
        errorMessage: e.toString(),
      ),
    );
  }

  Future<void> _onMarkAllRead(
    MarkAllNotificationsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await _repository.markAllRead(event.eventId);
  }
}
