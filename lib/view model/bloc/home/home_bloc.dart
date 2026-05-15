import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

export 'home_event.dart';
export 'home_state.dart';

// HomeBloc is kept for future home-screen features.
// Animation is now owned by _HomeViewState (AnimationController).
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeLoadEvent>((_, emit) {});
  }
}
