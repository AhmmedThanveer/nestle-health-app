import '../../../core/models/chat_message.dart';
import '../../repositories/chat_repository.dart';

class WatchChatMessagesUseCase {
  final ChatRepository _repository;

  const WatchChatMessagesUseCase(this._repository);

  Stream<List<ChatMessage>> call({
    required String eventId,
    required String currentUserId,
  }) =>
      _repository.watchMessages(eventId: eventId, currentUserId: currentUserId);
}
