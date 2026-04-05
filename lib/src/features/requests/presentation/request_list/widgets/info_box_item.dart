import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class InfoBoxItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconBackgroundColor;

  const InfoBoxItem({
    super.key,
    required this.icon,
    required this.text,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.54;
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.onPrimary,
            size: AppSize.s18,
          ),
        ),
        const SizedBox(width: AppPadding.p12),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: BodyMediumText(
            text: text,
            fontSize: AppSize.s12,
            color: theme.colorScheme.onPrimaryFixedVariant,
          ),
        ),
      ],
    );
  }
}
