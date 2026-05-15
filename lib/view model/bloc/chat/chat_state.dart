import 'package:equatable/equatable.dart';

import '../../../core/models/chat_message.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;

  const ChatState({this.messages = const []});

  ChatState copyWith({List<ChatMessage>? messages}) =>
      ChatState(messages: messages ?? this.messages);

  @override
  List<Object?> get props => [messages];
}
