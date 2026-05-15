/// ===============================================
/// validation_utils.dart
/// ===============================================

class ValidationUtils {
  static String? validateRequired({
    required String value,
    required String fieldName,
  }) {
    if (value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? validateEmail(String value) {
    if (value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter valid email';
    }

    return null;
  }

  static String? validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? validateMobile(String value) {
    if (value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    if (value.length < 8) {
      return 'Please enter valid mobile number';
    }

    return null;
  }
}
