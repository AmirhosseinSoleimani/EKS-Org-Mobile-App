import 'dart:ui';

class ColorCodeParser {
  static Color parse(String? hex) {
    const fallback = Color(0xFF9E9E9E);

    if (hex == null || hex.isEmpty) return fallback;

    try {
      final cleaned = hex.replaceAll('#', '');

      if (cleaned.length == 6) {
        return Color(int.parse('0xFF$cleaned'));
      } else if (cleaned.length == 8) {
        return Color(int.parse('0x$cleaned'));
      }

      return fallback;
    } catch (_) {
      return fallback;
    }
  }
}
