import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class StatusLabel extends StatelessWidget {
  final String text;
  final Color color;

  const StatusLabel({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(51), // ≈ 20%
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(50),
      ),
      child: BodySmallText(
        text: text,
        color: color,
        fontSize: 10,
      ),
    );
  }
}
