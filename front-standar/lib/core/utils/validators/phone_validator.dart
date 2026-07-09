/// Phone number validator utility class
///
/// Provides validation methods for phone numbers
class PhoneValidator {
  PhoneValidator._();

  static final RegExp _phoneRegex = RegExp(
    r'^[+]?[(]?[0-9]{1,4}[)]?[-\s./0-9]*$',
  );
  static String? validate(
    String? value, {
    String? emptyMessage,
    String? invalidMessage,
    int minLength = 8,
    int maxLength = 15,
  }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage ?? 'Le numéro de téléphone est requis';
    }

    final cleanedValue = value.replaceAll(RegExp(r'[\s\-()./]'), '');

    if (!_phoneRegex.hasMatch(value)) {
      return invalidMessage ?? 'Veuillez entrer un numéro de téléphone valide';
    }

    // Remove non-digit characters for length check
    final digitsOnly = cleanedValue.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < minLength) {
      return 'Le numéro de téléphone doit contenir au moins $minLength chiffres';
    }

    if (digitsOnly.length > maxLength) {
      return 'Le numéro de téléphone doit contenir au maximum $maxLength chiffres';
    }

    return null;
  }
}
