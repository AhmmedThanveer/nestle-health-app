import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/agenda_models.dart';
import 'agenda_event.dart';
import 'agenda_state.dart';

export 'agenda_event.dart';
export 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc()
      : super(const AgendaState(days: AgendaData.days)) {
    on<SelectDayEvent>(_onSelectDay);
    on<SelectHallEvent>(_onSelectHall);
  }

  void _onSelectDay(SelectDayEvent event, Emitter<AgendaState> emit) {
    if (event.dayIndex == state.selectedDay) return;
    emit(state.copyWith(selectedDay: event.dayIndex, selectedHall: 0));
  }

  void _onSelectHall(SelectHallEvent event, Emitter<AgendaState> emit) {
    if (event.hallIndex == state.selectedHall) return;
    emit(state.copyWith(selectedHall: event.hallIndex));
  }
}
