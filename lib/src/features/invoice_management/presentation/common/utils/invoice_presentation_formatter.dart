import 'package:flutter/material.dart';

class InvoicePresentationFormatter {
  const InvoicePresentationFormatter._();

  static String display(String? value, {String fallback = '---'}) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? fallback : normalized;
  }

  static String requestCode(int? value) {
    return value == null ? 'REQ----' : 'REQ-$value}';
  }

  static String rial(int? value) {
    if (value == null) return '---';
    final formatted = _withCommas(value.toString());
    return value == 0 ? '0' : '$formatted ریال';
  }

  static String number(int? value) {
    return value == null ? '---' : value.toString();
  }

  static String agency(String? name, String? code) {
    final normalizedName = name?.trim();
    final normalizedCode = code?.trim();

    if ((normalizedName == null || normalizedName.isEmpty) &&
        (normalizedCode == null || normalizedCode.isEmpty)) {
      return '---';
    }

    if (normalizedName == null || normalizedName.isEmpty) {
      return normalizedCode!;
    }

    if (normalizedCode == null || normalizedCode.isEmpty) {
      return normalizedName;
    }

    return '$normalizedName ($normalizedCode})';
  }

  static Color statusColor(BuildContext context, int? status) {
    return switch (status) {
      0 => const Color(0xFF2E7D32),
      1 => const Color(0xFF1565C0),
      2 => const Color(0xFF00897B),
      _ => Theme.of(context).colorScheme.onSurfaceVariant,
    };
  }

  static String _withCommas(String value) {
    final isNegative = value.startsWith('-');
    final digits = isNegative ? value.substring(1) : value;
    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      if (index != 0 && (digits.length - index) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[index]);
    }

    return isNegative ? '-$buffer' : buffer.toString();
  }
}
