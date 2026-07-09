/// Utility class for phone number formatting.
class PhoneFormatter {
  PhoneFormatter._();

  /// Removes leading zero(s) from a phone number.
  ///
  /// Example:
  /// - "0612345678" → "612345678"
  /// - "00612345678" → "612345678"
  /// - "612345678" → "612345678" (no change)
  static String removeLeadingZero(String phoneNumber) {
    if (phoneNumber.isEmpty) return phoneNumber;

    // Remove all leading zeros
    String result = phoneNumber;
    while (result.isNotEmpty && result.startsWith('0')) {
      result = result.substring(1);
    }
    return result;
  }

  /// Formats a phone number by removing leading zeros and non-digit characters.
  static String format(String phoneNumber) {
    // Remove non-digit characters except +
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return removeLeadingZero(digitsOnly);
  }
}
