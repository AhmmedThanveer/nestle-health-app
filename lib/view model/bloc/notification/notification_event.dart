import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class WatchNotificationsEvent extends NotificationEvent {
  final String eventId;
  const WatchNotificationsEvent(this.eventId);
  @override
  List<Object?> get props => [eventId];
}

class MarkAllNotificationsReadEvent extends NotificationEvent {
  final String eventId;
  const MarkAllNotificationsReadEvent(this.eventId);
  @override
  List<Object?> get props => [eventId];
}
