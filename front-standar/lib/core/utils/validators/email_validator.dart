/// Email validator utility class
///
/// Provides validation methods for email addresses
class EmailValidator {
  /// Private constructor to prevent instantiation
  EmailValidator._();

  /// Regular expression pattern for validating email addresses
  /// Based on RFC 5322 simplified pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validates if the given value is a valid email address
  ///
  /// Parameters:
  /// - [value]: The email string to validate
  /// - [emptyMessage]: Custom message when email is empty (optional)
  /// - [invalidMessage]: Custom message when email format is invalid (optional)
  ///
  /// Returns:
  /// - `null` if the email is valid
  /// - An error message string if the email is invalid
  static String? validate(
    String? value, {
    String? emptyMessage,
    String? invalidMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage ?? 'L\'email est requis';
    }

    final trimmedValue = value.trim();

    if (!_emailRegex.hasMatch(trimmedValue)) {
      return invalidMessage ?? 'Veuillez entrer une adresse email valide';
    }

    return null;
  }

  /// Checks if the given string is a valid email format
  ///
  /// Returns `true` if valid, `false` otherwise
  static bool isValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return false;
    }
    return _emailRegex.hasMatch(value.trim());
  }
}
