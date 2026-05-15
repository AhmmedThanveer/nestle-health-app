import 'package:equatable/equatable.dart';

import '../../../core/models/agenda_models.dart';

class AgendaState extends Equatable {
  final List<AgendaDay> days;
  final int selectedDay;
  final int selectedHall;

  const AgendaState({
    required this.days,
    this.selectedDay = 0,
    this.selectedHall = 0,
  });

  AgendaDay get currentDay => days[selectedDay];
  AgendaHall get currentHall => currentDay.halls[selectedHall];

  AgendaState copyWith({int? selectedDay, int? selectedHall}) => AgendaState(
        days: days,
        selectedDay: selectedDay ?? this.selectedDay,
        selectedHall: selectedHall ?? this.selectedHall,
      );

  @override
  List<Object?> get props => [selectedDay, selectedHall];
}
