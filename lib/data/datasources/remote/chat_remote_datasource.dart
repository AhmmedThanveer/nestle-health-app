import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/models/chat_message.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatMessage>> watchMessages({
    required String eventId,
    required String currentUserId,
  });

  Future<void> sendMessage({
    required String eventId,
    required String userId,
    required String userName,
    required String text,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _db;

  ChatRemoteDataSourceImpl(this._db);

  @override
  Stream<List<ChatMessage>> watchMessages({
    required String eventId,
    required String currentUserId,
  }) {
    return _db
        .collection('message')
        .where('eventId', isEqualTo: eventId)
        .orderBy('timestamp')
        .snapshots()
        .map((snap) => snap.docs.map((doc) {
              final d = doc.data() as Map<String, dynamic>? ?? {};
              final userId = d['userId'] as String? ?? '';
              return ChatMessage(
                id: doc.id,
                userId: userId,
                userName: d['userName'] as String? ?? '',
                text: d['text'] as String? ?? '',
                timestamp:
                    (d['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
                isSentByUser: userId == currentUserId,
              );
            }).toList());
  }

  @override
  Future<void> sendMessage({
    required String eventId,
    required String userId,
    required String userName,
    required String text,
  }) async {
    await _db.collection('message').add({
      'eventId': eventId,
      'userId': userId,
      'userName': userName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
