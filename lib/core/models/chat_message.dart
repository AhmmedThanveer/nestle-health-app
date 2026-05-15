class ChatMessage {
  final String text;
  final bool isSentByUser;
  final String time;

  const ChatMessage({
    required this.text,
    required this.isSentByUser,
    required this.time,
  });
}
