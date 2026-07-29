import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class SpecialPlanInfoRow extends StatelessWidget {
  const SpecialPlanInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onTertiaryFixed;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: AppSize.s18),
        Space.w8,
        TitleMediumText(
          text: '$label:',
          color: color,
          fontSize: AppSize.s14,
          fontWeight: FontWeight.w700,
        ),
        Space.w4,
        Expanded(
          child: BodySmallText(
            text: value,
            color: color,
            fontSize: AppSize.s14,
            maxLines: maxLines,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
