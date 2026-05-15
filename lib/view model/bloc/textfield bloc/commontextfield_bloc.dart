/// =======================================================
/// common_textfield_bloc.dart
/// =======================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import 'common_textfield_event.dart';
import 'common_textfield_state.dart';

class CommonTextFieldBloc
    extends Bloc<CommonTextFieldEvent, CommonTextFieldState> {
  final String? Function(String?)? validator;

  CommonTextFieldBloc({this.validator}) : super(const CommonTextFieldState()) {
    on<TextFieldFocusChanged>(_onFocusChanged);

    on<TextFieldValueChanged>(_onValueChanged);
  }

  void _onFocusChanged(
    TextFieldFocusChanged event,
    Emitter<CommonTextFieldState> emit,
  ) {
    emit(state.copyWith(isFocused: event.isFocused));
  }

  void _onValueChanged(
    TextFieldValueChanged event,
    Emitter<CommonTextFieldState> emit,
  ) {
    String? error;

    if (validator != null) {
      error = validator!(event.value);
    }

    emit(state.copyWith(errorText: error));
  }
}
