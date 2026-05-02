import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class KeyValueWidgetRow extends StatelessWidget {
  final String label;
  final Widget? leadingWidget;
  final Widget value;

  const KeyValueWidgetRow({
    super.key,
    required this.label,
    required this.value,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Expanded(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingWidget != null) ...[
                  leadingWidget!,
                  const SizedBox(width: 4),
                ],
                Flexible(
                  child: BodySmallText(text: label),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          Flexible(
            child: value,
          ),
        ],
      ),
    );
  }
}
