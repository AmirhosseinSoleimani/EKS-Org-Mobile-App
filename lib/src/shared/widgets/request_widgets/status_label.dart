import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

enum StatusLabelVariant {
  filled,
  outlined,
  filledWhiteText,
  filledWithoutBorder,
}


class StatusLabel extends StatelessWidget {
  final String text;
  final Color color;
  final Color? backgroundColor;
  final StatusLabelVariant variant;
  final double fontSize;
  final double? width;
  final double borderRadius;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final FontWeight? fontWeight;

  const StatusLabel({
    super.key,
    required this.text,
    required this.color,
    this.backgroundColor,
    this.fontSize = 12,
    this.variant = StatusLabelVariant.filled,
    this.width,
    this.borderRadius = 50,
    this.textAlign = TextAlign.center,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackgroundColor = _resolveBackgroundColor();
    final Color resolvedTextColor = _resolveTextColor(resolvedBackgroundColor);

    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: resolvedBackgroundColor,
        border: (variant == StatusLabelVariant.filledWithoutBorder)? null: Border.all(color: color),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: BodySmallText(
        text: text,
        color: resolvedTextColor,
        fontSize: fontSize,
        textAlign: textAlign,fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }

  Color _resolveBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;

    switch (variant) {
      case StatusLabelVariant.filled:
        return color.withValues(alpha: 0.1);

      case StatusLabelVariant.outlined:
        return Colors.transparent;

      case StatusLabelVariant.filledWhiteText:
        return color;
      case StatusLabelVariant.filledWithoutBorder:
        return color.withValues(alpha: 0.1);
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
      case StatusLabelVariant.filledWithoutBorder:
        return color;

      case StatusLabelVariant.filledWhiteText:
        return Colors.white;
    }
  }
}

