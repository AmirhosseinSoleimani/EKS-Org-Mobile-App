class RescuerFormValidator {
  const RescuerFormValidator._();

  static String? requiredText(String? value, String title) {
    return value == null || value.trim().isEmpty ? '$title الزامی است' : null;
  }

  static String? requiredSelection(Object? value, String title) {
    return value == null ? '$title الزامی است' : null;
  }
}
