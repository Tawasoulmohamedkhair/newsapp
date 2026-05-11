class AppValidator {
  /// Email RegExp
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Password RegExp
  /// At least:
  /// - 8 characters
  /// - 1 uppercase
  /// - 1 lowercase
  /// - 1 number
  /// - 1 special character
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
  );

  static bool isValidEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return _passwordRegex.hasMatch(password);
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (!_passwordRegex.hasMatch(value)) {
      return "Password must contain 8 chars, uppercase, lowercase, number and symbol";
    }

    return null;
  }

  /// ⭐ NEW → Confirm Password Validator
  static String? confirmPasswordValidator(
    String? confirmPassword,
    String password,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm Password is required";
    }

    if (confirmPassword != password) {
      return "Passwords do not match";
    }

    return null;
  }
}
