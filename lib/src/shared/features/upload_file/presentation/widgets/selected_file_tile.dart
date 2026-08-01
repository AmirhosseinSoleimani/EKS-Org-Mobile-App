import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class SelectedFileTile extends StatelessWidget {
  const SelectedFileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onRemove,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget icon;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          icon,
          Space.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyMediumText(
                  text: title,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                ),
                if (subtitle?.trim().isNotEmpty == true) ...[
                  Space.h4,
                  BodySmallText(
                    text: subtitle!,
                    color: colorScheme.onTertiaryFixed,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Space.w8,
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
