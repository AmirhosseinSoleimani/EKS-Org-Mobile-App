import 'package:eks_sana_plus_org/src/common/utils/extensions/color_code_parser.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:flutter/material.dart';

class DashboardChartColorResolver {
  const DashboardChartColorResolver._();

  static List<Color> resolveSeries({
    required BuildContext context,
    required List<ChartDataEntity> items,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final familyUsages = <_ChartColorFamily, int>{};

    for (final item in items) {
      final serverColor = _serverColor(item);
      if (serverColor == null) {
        continue;
      }

      final family = _familyOf(serverColor);
      familyUsages[family] = (familyUsages[family] ?? 0) + 1;
    }

    return items.asMap().entries.map((entry) {
      final item = entry.value;
      final serverColor = _serverColor(item);
      if (serverColor != null) {
        return serverColor;
      }

      final baseColor = _colorByCode(colorScheme, item.code) ??
          _fallbackPalette(colorScheme)[
              entry.key % _fallbackPalette(colorScheme).length];
      final family = _familyOf(baseColor);
      final usage = familyUsages[family] ?? 0;

      familyUsages[family] = usage + 1;
      return _tonalVariant(baseColor, usage);
    }).toList();
  }

  static Color resolve({
    required BuildContext context,
    required ChartDataEntity item,
    required int index,
  }) {
    final serverColor = _serverColor(item);
    if (serverColor != null) {
      return serverColor;
    }

    final colorScheme = Theme.of(context).colorScheme;
    return _colorByCode(colorScheme, item.code) ??
        _fallbackPalette(colorScheme)[index % _fallbackPalette(colorScheme).length];
  }

  static Color? _serverColor(ChartDataEntity item) {
    final value = item.color?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return ColorCodeParser.parse(value);
  }

  static Color _tonalVariant(Color color, int usage) {
    if (usage == 0) {
      return color;
    }

    final hsl = HSLColor.fromColor(color);
    final variantIndex = (usage - 1) % 3;

    return switch (variantIndex) {
      0 => hsl
          .withSaturation((hsl.saturation * 0.62).clamp(0.0, 1.0).toDouble())
          .withLightness((hsl.lightness + 0.18).clamp(0.0, 0.88).toDouble())
          .toColor(),
      1 => hsl
          .withSaturation((hsl.saturation * 0.82).clamp(0.0, 1.0).toDouble())
          .withLightness((hsl.lightness - 0.10).clamp(0.12, 1.0).toDouble())
          .toColor(),
      _ => hsl
          .withSaturation((hsl.saturation * 0.48).clamp(0.0, 1.0).toDouble())
          .withLightness((hsl.lightness + 0.28).clamp(0.0, 0.92).toDouble())
          .toColor(),
    };
  }

  static _ChartColorFamily _familyOf(Color color) {
    final hsl = HSLColor.fromColor(color);
    if (hsl.saturation < 0.16) {
      return _ChartColorFamily.neutral;
    }

    final hue = hsl.hue;
    if (hue < 15 || hue >= 345) {
      return _ChartColorFamily.red;
    }
    if (hue < 50) {
      return _ChartColorFamily.orange;
    }
    if (hue < 75) {
      return _ChartColorFamily.yellow;
    }
    if (hue < 165) {
      return _ChartColorFamily.green;
    }
    if (hue < 205) {
      return _ChartColorFamily.cyan;
    }
    if (hue < 260) {
      return _ChartColorFamily.blue;
    }
    if (hue < 320) {
      return _ChartColorFamily.purple;
    }
    return _ChartColorFamily.pink;
  }

  static Color? _colorByCode(ColorScheme colors, String code) {
    return switch (code) {
      '1' => colors.primary,
      '2' => colors.error,
      '3' => const Color(0xFF18B89F),
      '4' => const Color(0xFFC45ABF),
      '5' => const Color(0xFFB744AB),
      '6' => const Color(0xFF8064C3),
      '7' => const Color(0xFF4A9F55),
      '8' => colors.onSecondaryFixed,
      '9' => colors.secondary,
      'UnderOperation' => colors.onPrimaryFixed,
      'ArrivedEmdadgar' => colors.onPrimaryContainer,
      'MovedEmdadgar' => colors.secondary,
      'AssignEmdadgar' => const Color(0xFF7462A5),
      'Canceled' => colors.error,
      'Close' => const Color(0xFF8D3636),
      'Completed' => const Color(0xFF27966F),
      'Initial' => const Color(0xFFD95669),
      _ => null,
    };
  }

  static List<Color> _fallbackPalette(ColorScheme colors) => [
        colors.secondary,
        const Color(0xFF27966F),
        const Color(0xFF8064C3),
        const Color(0xFFD95669),
        colors.onPrimaryContainer,
        colors.onPrimaryFixed,
        const Color(0xFF18B89F),
        const Color(0xFFB744AB),
        colors.error,
        colors.primary,
        const Color(0xFFE7B93F),
        const Color(0xFFC45ABF),
        const Color(0xFF4A9F55),
        const Color(0xFF58B8C1),
        const Color(0xFF397FC4),
        const Color(0xFF9B4BA5),
        const Color(0xFF4B9B88),
        const Color(0xFFE0A34C),
        const Color(0xFFD66A58),
        const Color(0xFF347EAE),
        const Color(0xFF5B8451),
        const Color(0xFFC963B5),
        const Color(0xFF6650A4),
      ];
}

enum _ChartColorFamily {
  red,
  orange,
  yellow,
  green,
  cyan,
  blue,
  purple,
  pink,
  neutral,
}
