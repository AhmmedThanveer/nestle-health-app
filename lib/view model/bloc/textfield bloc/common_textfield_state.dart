import 'package:equatable/equatable.dart';

class CommonTextFieldState extends Equatable {
  final bool isFocused;
  final bool isTouched; // true after the first focus-then-blur cycle
  final String? errorText;

  const CommonTextFieldState({
    this.isFocused = false,
    this.isTouched = false,
    this.errorText,
  });

  CommonTextFieldState copyWith({
    bool? isFocused,
    bool? isTouched,
    String? errorText,
    bool clearError = false,
  }) {
    return CommonTextFieldState(
      isFocused: isFocused ?? this.isFocused,
      isTouched: isTouched ?? this.isTouched,
      errorText: clearError ? null : (errorText ?? this.errorText),
    );
  }

  @override
  List<Object?> get props => [isFocused, isTouched, errorText];
}
