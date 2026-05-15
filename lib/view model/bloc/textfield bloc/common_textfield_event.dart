/// =======================================================
/// common_textfield_event.dart
/// =======================================================

abstract class CommonTextFieldEvent {}

class TextFieldFocusChanged extends CommonTextFieldEvent {
  final bool isFocused;

  TextFieldFocusChanged(this.isFocused);
}

class TextFieldValueChanged extends CommonTextFieldEvent {
  final String value;

  TextFieldValueChanged(this.value);
}
