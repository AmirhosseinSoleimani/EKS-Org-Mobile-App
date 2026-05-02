import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final Widget? leadingWidget;
  final String label;
  final String value;
  final bool boldLabel;
  final bool boldValue;
  final double? labelFontSize;
  final double? valueFontSize;
  final MainAxisAlignment mainAxisAlignment;

  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.boldLabel = false,
    this.boldValue = false,
    this.labelFontSize,
    this.valueFontSize,
    this.leadingWidget,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingWidget != null) ...[
                leadingWidget!,
                const SizedBox(width: 4),
              ],
              Flexible(
                child: BodySmallText(
                  text: label,
                  fontWeight: boldLabel ? FontWeight.bold : FontWeight.normal,
                  fontSize: labelFontSize,
                ),
              ),
            ],
          ),
          Space.w4,
          Flexible(
            child: BodySmallText(
              text: value,
              textAlign: TextAlign.end,
              fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
              fontSize: valueFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
