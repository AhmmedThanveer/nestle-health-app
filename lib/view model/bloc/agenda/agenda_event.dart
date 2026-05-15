import 'package:equatable/equatable.dart';

abstract class AgendaEvent extends Equatable {
  const AgendaEvent();
  @override
  List<Object?> get props => [];
}

class LoadAgendaEvent extends AgendaEvent {
  final String eventId;
  const LoadAgendaEvent(this.eventId);
  @override
  List<Object?> get props => [eventId];
}

class SelectDayEvent extends AgendaEvent {
  final int dayIndex;
  const SelectDayEvent(this.dayIndex);
  @override
  List<Object?> get props => [dayIndex];
}

class SelectHallEvent extends AgendaEvent {
  final int hallIndex;
  const SelectHallEvent(this.hallIndex);
  @override
  List<Object?> get props => [hallIndex];
}
