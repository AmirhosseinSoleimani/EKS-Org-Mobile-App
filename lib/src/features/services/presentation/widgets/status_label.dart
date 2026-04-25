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
  final StatusLabelVariant variant;

  const StatusLabel({
    super.key,
    required this.text,
    required this.color,
    this.variant = StatusLabelVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color borderColor = color;
    final Color textColor;

    switch (variant) {
      case StatusLabelVariant.filled:
        backgroundColor = color.withAlpha(51); // ≈20%
        textColor = color;
        break;

      case StatusLabelVariant.outlined:
        backgroundColor = Colors.transparent;
        textColor = color;
        break;

      case StatusLabelVariant.filledWhiteText:
        backgroundColor = color;
        textColor = Colors.white;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: BodySmallText(
        text: text,
        color: textColor,
        fontSize: 10,
        textAlign: TextAlign.center,
      ),
    );
  }
}
