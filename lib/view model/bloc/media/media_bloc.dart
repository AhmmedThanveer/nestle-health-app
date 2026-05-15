import 'package:flutter_bloc/flutter_bloc.dart';

import 'media_event.dart';
import 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(const MediaState()) {
    on<SelectMediaTypeEvent>(_onSelectType);
  }

  void _onSelectType(SelectMediaTypeEvent event, Emitter<MediaState> emit) {
    if (event.type != state.selectedType) {
      emit(state.copyWith(selectedType: event.type));
    }
  }
}
