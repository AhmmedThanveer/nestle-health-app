import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

export 'chat_event.dart';
export 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(const ChatState(messages: [
          ChatMessage(
            text: 'Welcome to Nestlé Congress Live Chat! How can we help you?',
            isSentByUser: false,
            time: '10:00 AM',
          ),
        ])) {
    on<SendMessageEvent>(_onSend);
  }

  void _onSend(SendMessageEvent event, Emitter<ChatState> emit) {
    if (event.text.trim().isEmpty) return;
    emit(state.copyWith(
      messages: [
        ...state.messages,
        ChatMessage(
          text: event.text.trim(),
          isSentByUser: true,
          time: _formatTime(DateTime.now()),
        ),
      ],
    ));
  }

  String _formatTime(DateTime dt) {
    final int hour =
        dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final String minute = dt.minute.toString().padLeft(2, '0');
    final String period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
