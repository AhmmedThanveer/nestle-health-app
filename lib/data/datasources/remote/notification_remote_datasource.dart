import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Stream<List<NotificationModel>> watchNotifications(String eventId);
  Future<void> markAllRead(String eventId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore _db;

  NotificationRemoteDataSourceImpl(this._db);

  CollectionReference<Map<String, dynamic>> get _notifications =>
      _db.collection('notifications');

  @override
  Stream<List<NotificationModel>> watchNotifications(String eventId) {
    return _notifications
        .where('eventId', isEqualTo: eventId.trim())
        .snapshots()
        .map((snap) {
          final list = snap.docs
              .map((doc) => NotificationModel.fromFirestore(doc))
              .toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
          return list;
        });
  }

  @override
  Future<void> markAllRead(String eventId) async {
    final batch = _db.batch();
    final unread = await _notifications
        .where('eventId', isEqualTo: eventId)
        .where('isRead', isEqualTo: false)
        .get();
    for (final doc in unread.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }
}
