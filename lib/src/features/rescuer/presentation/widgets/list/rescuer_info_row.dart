import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RescuerInfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const RescuerInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgWidget(src: SvgAsset(icon)),
          const SizedBox(width: 8),
          Expanded(
            child: BodyMediumText(
              text: '$label: $value',
              color: colorScheme.onTertiaryFixed,
              fontSize: 13,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
