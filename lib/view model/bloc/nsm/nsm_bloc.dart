import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/service_locator.dart';
import '../../../domain/usecases/nsm/get_nsm_days_usecase.dart';
import 'nsm_event.dart';
import 'nsm_state.dart';

export 'nsm_event.dart';
export 'nsm_state.dart';

class NsmBloc extends Bloc<NsmEvent, NsmState> {
  final GetNsmDaysUseCase _getNsmDays;

  NsmBloc()
      : _getNsmDays = sl<GetNsmDaysUseCase>(),
        super(const NsmLoadingState()) {
    on<LoadNsmEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadNsmEvent event, Emitter<NsmState> emit) async {
    emit(const NsmLoadingState());

    final result = await _getNsmDays();

    result.when(
      success: (days) => emit(NsmLoadedState(days: days)),
      failure: (f) => emit(NsmErrorState(f.message)),
    );
  }
}
