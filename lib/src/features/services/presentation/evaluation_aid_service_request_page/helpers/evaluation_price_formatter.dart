class EvaluationPriceFormatter {
  EvaluationPriceFormatter._();

  static int parse(String value) {
    final normalized = value.replaceAll(RegExp(r'[^0-9]'), '').trim();
    return int.tryParse(normalized) ?? 0;
  }

  static String format(Object? value) {
    final rawValue = value?.toString() ?? '';
    if (rawValue.isEmpty) return '';

    final digits = rawValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';

    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}
