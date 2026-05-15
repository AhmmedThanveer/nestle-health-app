import '../../entities/notification_entity.dart';
import '../../repositories/notification_repository.dart';

class WatchNotificationsUseCase {
  final NotificationRepository _repository;
  const WatchNotificationsUseCase(this._repository);

  Stream<List<NotificationEntity>> call(String eventId) =>
      _repository.watchNotifications(eventId);
}
