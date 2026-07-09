class RequiredValidator {
  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Champ est obligatoire';
    }
    return null;
  }
}
