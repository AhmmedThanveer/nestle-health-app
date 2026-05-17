import '../../core/models/chat_message.dart';
import '../../core/utils/result.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> watchMessages({
    required String eventId,
    required String currentUserId,
  });

  Future<Result<void>> sendMessage({
    required String eventId,
    required String userId,
    required String userName,
    required String text,
  });
}
