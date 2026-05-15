import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/nsm_models.dart';
import 'nsm_event.dart';
import 'nsm_state.dart';

class NsmBloc extends Bloc<NsmEvent, NsmState> {
  NsmBloc() : super(const NsmLoadingState()) {
    on<LoadNsmEvent>(_onLoad);
  }

  void _onLoad(LoadNsmEvent event, Emitter<NsmState> emit) {
    emit(const NsmLoadedState(days: NsmData.days));
  }
}
