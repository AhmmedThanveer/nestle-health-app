import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/speaker/get_speakers_usecase.dart';
import 'speakers_event.dart';
import 'speakers_state.dart';

export 'speakers_event.dart';
export 'speakers_state.dart';

class SpeakersBloc extends Bloc<SpeakersEvent, SpeakersState> {
  final GetSpeakersUseCase _getSpeakers;

  SpeakersBloc()
      : _getSpeakers = sl<GetSpeakersUseCase>(),
        super(const SpeakersState()) {
    on<LoadSpeakersEvent>(_onLoad);
    on<SelectSpeakerCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onLoad(
    LoadSpeakersEvent event,
    Emitter<SpeakersState> emit,
  ) async {
    emit(state.copyWith(status: SpeakersStatus.loading));
    final result = await _getSpeakers(event.eventId);
    result.when(
      success: (speakers) => emit(state.copyWith(
        status: SpeakersStatus.loaded,
        allSpeakers: speakers,
      )),
      failure: (f) => emit(state.copyWith(
        status: SpeakersStatus.error,
        errorMessage: f.message,
      )),
    );
  }

  void _onSelectCategory(
    SelectSpeakerCategoryEvent event,
    Emitter<SpeakersState> emit,
  ) {
    if (event.category != state.selectedCategory) {
      emit(state.copyWith(selectedCategory: event.category));
    }
  }
}
