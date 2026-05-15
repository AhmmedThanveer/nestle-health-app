import 'package:equatable/equatable.dart';

import '../../../core/models/agenda_models.dart';

enum AgendaStatus { initial, loading, loaded, error }

class AgendaState extends Equatable {
  final AgendaStatus status;
  final List<AgendaDay> days;
  final int selectedDay;
  final int selectedHall;
  final String? errorMessage;

  const AgendaState({
    this.status = AgendaStatus.initial,
    this.days = const [],
    this.selectedDay = 0,
    this.selectedHall = 0,
    this.errorMessage,
  });

  bool get hasData => days.isNotEmpty;
  AgendaDay? get currentDay => hasData ? days[selectedDay] : null;
  AgendaHall? get currentHall => currentDay != null
      ? currentDay!.halls[selectedHall]
      : null;

  AgendaState copyWith({
    AgendaStatus? status,
    List<AgendaDay>? days,
    int? selectedDay,
    int? selectedHall,
    String? errorMessage,
  }) =>
      AgendaState(
        status: status ?? this.status,
        days: days ?? this.days,
        selectedDay: selectedDay ?? this.selectedDay,
        selectedHall: selectedHall ?? this.selectedHall,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props =>
      [status, days, selectedDay, selectedHall, errorMessage];
}
