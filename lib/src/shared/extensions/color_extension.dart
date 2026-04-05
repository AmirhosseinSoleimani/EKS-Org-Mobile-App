import 'package:flutter/material.dart';

class ColorUtils {
  const ColorUtils._();

  static Color? hexToColor(String? hex) {
    if (hex == null || hex.trim().isEmpty) return null;
    var s = hex.trim().toUpperCase();
    if (s.startsWith('#')) s = s.substring(1);
    if (s.startsWith('0X')) s = s.substring(2);
    if (s.length == 3) {
      s = s.split('').map((c) => '$c$c').join();
    }
    if (s.length == 6) s = 'FF$s';
    if (s.length != 8) return null;
    final value = int.tryParse(s, radix: 16);
    if (value == null) return null;
    return Color(value);
  }
}

extension IterableToMapX<T> on Iterable<T> {
  Map<K, V> toIdMap<K, V>(K Function(T) keyOf, V Function(T) valueOf) {
    final map = <K, V>{};
    for (final item in this) {
      map[keyOf(item)] = valueOf(item);
    }
    return map;
  }
}