import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

export 'home_event.dart';
export 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(HomeLoadEvent event, Emitter<HomeState> emit) async {
    // Let the first frame render before starting entrance animations.
    await Future.delayed(const Duration(milliseconds: 120));
    emit(state.copyWith(isLoaded: true));
  }
}
