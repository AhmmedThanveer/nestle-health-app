/// =======================================================
/// common_textfield_state.dart
/// =======================================================

import 'package:equatable/equatable.dart';

class CommonTextFieldState extends Equatable {
  final bool isFocused;

  final String? errorText;

  const CommonTextFieldState({this.isFocused = false, this.errorText});

  CommonTextFieldState copyWith({bool? isFocused, String? errorText}) {
    return CommonTextFieldState(
      isFocused: isFocused ?? this.isFocused,
      errorText: errorText,
    );
  }

  @override
  List<Object?> get props => [isFocused, errorText];
}
