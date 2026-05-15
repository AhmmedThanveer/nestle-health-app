import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

export 'register_event.dart';
export 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterButtonPressedEvent>(_onRegisterPressed);
  }

  Future<void> _onRegisterPressed(
    RegisterButtonPressedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      clearError: true,
    ));

    try {
      // TODO: replace with Firebase Auth createUserWithEmailAndPassword
      // + Firestore document write for the user profile.
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
