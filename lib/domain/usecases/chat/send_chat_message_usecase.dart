import '../../../core/utils/result.dart';
import '../../repositories/chat_repository.dart';

class SendChatMessageUseCase {
  final ChatRepository _repository;

  const SendChatMessageUseCase(this._repository);

  Future<Result<void>> call({
    required String eventId,
    required String userId,
    required String userName,
    required String text,
  }) =>
      _repository.sendMessage(
        eventId: eventId,
        userId: userId,
        userName: userName,
        text: text,
      );
}
