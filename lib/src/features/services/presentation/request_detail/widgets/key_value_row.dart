import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String value;

  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyMediumText(text: label),

          Flexible(
            child: BodyMediumText(
              text: value,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
