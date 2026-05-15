import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

export 'navigation_event.dart';
export 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigateToTabEvent>(_onNavigateToTab);
  }

  void _onNavigateToTab(
    NavigateToTabEvent event,
    Emitter<NavigationState> emit,
  ) {
    if (event.tabIndex == state.currentIndex) return;
    emit(state.copyWith(currentIndex: event.tabIndex));
  }
}
