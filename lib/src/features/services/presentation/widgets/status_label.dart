import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

enum StatusLabelVariant {
  filled,
  outlined,
  filledWhiteText,
}


class StatusLabel extends StatelessWidget {
  final String text;
  final Color color;
  final Color? backgroundColor;
  final StatusLabelVariant variant;
  final double fontSize;

  const StatusLabel({
    super.key,
    required this.text,
    required this.color,
    this.backgroundColor,
    this.fontSize = 10,
    this.variant = StatusLabelVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackgroundColor = _resolveBackgroundColor();
    final Color resolvedTextColor = _resolveTextColor(resolvedBackgroundColor);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: resolvedBackgroundColor,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(50),
      ),
      child: BodySmallText(
        text: text,
        color: resolvedTextColor,
        fontSize: fontSize,
        textAlign: TextAlign.center,
      ),
    );
  }

  Color _resolveBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;

    switch (variant) {
      case StatusLabelVariant.filled:
        return color.withOpacity(0.2);

      case StatusLabelVariant.outlined:
        return Colors.transparent;

      case StatusLabelVariant.filledWhiteText:
        return color;
    }
  }

  Color _resolveTextColor(Color bgColor) {
    if (backgroundColor != null) {
      return ThemeData.estimateBrightnessForColor(bgColor) ==
          Brightness.dark
          ? Colors.white
          : color;
    }

    switch (variant) {
      case StatusLabelVariant.filled:
      case StatusLabelVariant.outlined:
        return color;

      case StatusLabelVariant.filledWhiteText:
        return Colors.white;
    }
  }
}

