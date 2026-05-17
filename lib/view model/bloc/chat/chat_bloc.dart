import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/chat_message.dart';
import '../../../core/utils/session_store.dart';
import '../../../domain/usecases/chat/send_chat_message_usecase.dart';
import '../../../domain/usecases/chat/watch_chat_messages_usecase.dart';
import '../../../domain/usecases/user/get_current_user_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

export 'chat_event.dart';
export 'chat_state.dart';

class _MessagesUpdated extends ChatEvent {
  final List<ChatMessage> messages;
  const _MessagesUpdated(this.messages);
  @override
  List<Object> get props => [messages];
}

class _ChatStreamError extends ChatEvent {
  const _ChatStreamError();
  @override
  List<Object> get props => [];
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WatchChatMessagesUseCase _watchMessages;
  final SendChatMessageUseCase _sendMessage;
  final GetCurrentUserUseCase _getCurrentUser;

  StreamSubscription<List<ChatMessage>>? _sub;
  String _currentUserId = '';
  String _eventId = '';
  String _userName = '';

  ChatBloc({
    required WatchChatMessagesUseCase watchMessages,
    required SendChatMessageUseCase sendMessage,
    required GetCurrentUserUseCase getCurrentUser,
  })  : _watchMessages = watchMessages,
        _sendMessage = sendMessage,
        _getCurrentUser = getCurrentUser,
        super(const ChatState()) {
    on<WatchMessagesEvent>(_onWatch);
    on<_MessagesUpdated>(_onMessagesUpdated);
    on<_ChatStreamError>((_, emit) => emit(state.copyWith(status: ChatStatus.error)));
    on<SendMessageEvent>(_onSend);
  }

  Future<void> _onWatch(
    WatchMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    final uid = SessionStore.instance.currentUserId ?? '';
    if (uid.isEmpty) return;

    final userResult = await _getCurrentUser(uid);
    userResult.when(
      success: (user) {
        _currentUserId = user.uid;
        _eventId = user.eventId ?? '';
        _userName = user.fullName;
      },
      failure: (_) {},
    );

    if (_eventId.isEmpty) return;

    emit(state.copyWith(status: ChatStatus.loading));

    // Cancel any previous subscription before starting a new one.
    await _sub?.cancel();
    _sub = _watchMessages(eventId: _eventId, currentUserId: _currentUserId)
        .listen(
      (messages) => add(_MessagesUpdated(messages)),
      onError: (_) { if (!isClosed) add(const _ChatStreamError()); },
    );
    // _onWatch returns immediately — stream updates come via _MessagesUpdated.
  }

  void _onMessagesUpdated(
    _MessagesUpdated event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(status: ChatStatus.loaded, messages: event.messages));
  }

  Future<void> _onSend(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (event.text.trim().isEmpty || _eventId.isEmpty) return;
    emit(state.copyWith(isSending: true, sendError: () => null));

    final result = await _sendMessage(
      eventId: _eventId,
      userId: _currentUserId,
      userName: _userName,
      text: event.text.trim(),
    );

    result.when(
      success: (_) => emit(state.copyWith(isSending: false)),
      failure: (f) =>
          emit(state.copyWith(isSending: false, sendError: () => f.message)),
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
