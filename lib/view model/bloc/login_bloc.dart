import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
    });

    on<LoginButtonPressedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isLoginSuccess: false));

      // TODO: replace with real Firebase Auth call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isLoading: false, isLoginSuccess: true));
    });
  }
}
