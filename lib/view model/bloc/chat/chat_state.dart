import 'package:equatable/equatable.dart';

import '../../../core/models/chat_message.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final ChatStatus status;
  final bool isSending;
  final String? sendError;

  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.isSending = false,
    this.sendError,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
    bool? isSending,
    String? Function()? sendError,
  }) =>
      ChatState(
        messages: messages ?? this.messages,
        status: status ?? this.status,
        isSending: isSending ?? this.isSending,
        sendError: sendError != null ? sendError() : this.sendError,
      );

  @override
  List<Object?> get props => [messages, status, isSending, sendError];
}
