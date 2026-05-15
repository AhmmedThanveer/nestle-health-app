import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/agenda/get_agenda_usecase.dart';
import 'agenda_event.dart';
import 'agenda_state.dart';

export 'agenda_event.dart';
export 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  final GetAgendaUseCase _getAgenda;

  AgendaBloc()
      : _getAgenda = sl<GetAgendaUseCase>(),
        super(const AgendaState()) {
    on<LoadAgendaEvent>(_onLoad);
    on<SelectDayEvent>(_onSelectDay);
    on<SelectHallEvent>(_onSelectHall);
  }

  Future<void> _onLoad(
    LoadAgendaEvent event,
    Emitter<AgendaState> emit,
  ) async {
    emit(state.copyWith(status: AgendaStatus.loading));
    final result = await _getAgenda(event.eventId);
    result.when(
      success: (days) => emit(state.copyWith(
        status: AgendaStatus.loaded,
        days: days,
        selectedDay: 0,
        selectedHall: 0,
      )),
      failure: (f) => emit(state.copyWith(
        status: AgendaStatus.error,
        errorMessage: f.message,
      )),
    );
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
