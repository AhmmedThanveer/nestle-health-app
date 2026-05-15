import '../entities/notification_entity.dart';
import '../../core/utils/result.dart';

abstract class NotificationRepository {
  Stream<List<NotificationEntity>> watchNotifications(String eventId);
  Future<Result<void>> markAllRead(String eventId);
}
