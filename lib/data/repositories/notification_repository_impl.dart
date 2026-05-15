import '../../core/errors/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/remote/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Stream<List<NotificationEntity>> watchNotifications(String eventId) =>
      _dataSource.watchNotifications(eventId);

  @override
  Future<Result<void>> markAllRead(String eventId) async {
    try {
      await _dataSource.markAllRead(eventId);
      return const Success(null);
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
}
