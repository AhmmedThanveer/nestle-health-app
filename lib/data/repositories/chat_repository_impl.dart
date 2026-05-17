import '../../core/errors/failures.dart';
import '../../core/models/chat_message.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/remote/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remote;

  const ChatRepositoryImpl(this._remote);

  @override
  Stream<List<ChatMessage>> watchMessages({
    required String eventId,
    required String currentUserId,
  }) =>
      _remote.watchMessages(eventId: eventId, currentUserId: currentUserId);

  @override
  Future<Result<void>> sendMessage({
    required String eventId,
    required String userId,
    required String userName,
    required String text,
  }) async {
    try {
      await _remote.sendMessage(
        eventId: eventId,
        userId: userId,
        userName: userName,
        text: text,
      );
      return const Success(null);
    } catch (e) {
      return Failure(UnexpectedFailure(e.toString()));
    }
  }
}
