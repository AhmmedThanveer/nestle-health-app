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
    // Wait for the header animation to settle, then reveal the grid.
    await Future.delayed(const Duration(milliseconds: 600));
    emit(state.copyWith(isLoaded: true));
  }
}
