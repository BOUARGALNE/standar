/// Password validator utility class
///
/// Provides validation methods for passwords with configurable rules
class PasswordValidator {
  /// Private constructor to prevent instantiation
  PasswordValidator._();

  /// Default minimum password length
  static const int defaultMinLength = 8;

  /// Default maximum password length
  static const int defaultMaxLength = 128;

  /// Validates if the given value is a valid password
  ///
  /// Parameters:
  /// - [value]: The password string to validate
  /// - [emptyMessage]: Custom message when password is empty (optional)
  /// - [minLength]: Minimum required length (default: 8)
  /// - [maxLength]: Maximum allowed length (default: 128)
  /// - [requireUppercase]: Whether to require at least one uppercase letter
  /// - [requireLowercase]: Whether to require at least one lowercase letter
  /// - [requireDigit]: Whether to require at least one digit
  /// - [requireSpecialChar]: Whether to require at least one special character
  ///
  /// Returns:
  /// - `null` if the password is valid
  /// - An error message string if the password is invalid
  static String? validate(
    String? value, {
    String? emptyMessage,
    int minLength = defaultMinLength,
    int maxLength = defaultMaxLength,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireDigit = false,
    bool requireSpecialChar = false,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage ?? 'Le mot de passe est requis';
    }

    if (value.length < minLength) {
      return 'Le mot de passe doit contenir au moins $minLength caractères';
    }

    if (value.length > maxLength) {
      return 'Le mot de passe doit contenir au maximum $maxLength caractères';
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Le mot de passe doit contenir au moins une lettre minuscule';
    }

    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit contenir au moins un chiffre';
    }

    if (requireSpecialChar &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Le mot de passe doit contenir au moins un caractère spécial';
    }

    return null;
  }

  /// Simple validation that only checks for empty password
  ///
  /// Parameters:
  /// - [value]: The password string to validate
  /// - [emptyMessage]: Custom message when password is empty (optional)
  ///
  /// Returns:
  /// - `null` if the password is not empty
  /// - An error message string if the password is empty
  static String? validateNotEmpty(String? value, {String? emptyMessage}) {
    if (value == null || value.isEmpty) {
      return emptyMessage ?? 'Le mot de passe est requis';
    }
    return null;
  }

  /// Validates that the confirmation password matches the original password
  ///
  /// Parameters:
  /// - [value]: The confirmation password to validate
  /// - [originalPassword]: The original password to compare against
  /// - [emptyMessage]: Custom message when confirmation is empty (optional)
  /// - [mismatchMessage]: Custom message when passwords don't match (optional)
  ///
  /// Returns:
  /// - `null` if the passwords match
  /// - An error message string if they don't match or confirmation is empty
  static String? validateConfirmation(
    String? value, {
    required String originalPassword,
    String? emptyMessage,
    String? mismatchMessage,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage ?? 'Veuillez confirmer votre mot de passe';
    }

    if (value != originalPassword) {
      return mismatchMessage ?? 'Les mots de passe ne correspondent pas';
    }

    return null;
  }

  /// Checks if the password meets complexity requirements
  ///
  /// Returns a map with the status of each requirement
  static Map<String, bool> checkComplexity(String? value) {
    return {
      'hasMinLength': value != null && value.length >= defaultMinLength,
      'hasUppercase': value != null && value.contains(RegExp(r'[A-Z]')),
      'hasLowercase': value != null && value.contains(RegExp(r'[a-z]')),
      'hasDigit': value != null && value.contains(RegExp(r'[0-9]')),
      'hasSpecialChar':
          value != null && value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    };
  }
}
