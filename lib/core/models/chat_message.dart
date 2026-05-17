class ChatMessage {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;
  final bool isSentByUser;

  const ChatMessage({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
    required this.isSentByUser,
  });

  String get time {
    final hour = timestamp.hour > 12
        ? timestamp.hour - 12
        : (timestamp.hour == 0 ? 12 : timestamp.hour);
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
