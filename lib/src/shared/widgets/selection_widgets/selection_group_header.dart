import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SelectionGroupHeader extends StatelessWidget {
  const SelectionGroupHeader({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: AppSize.s20,
            color: theme.colorScheme.onTertiaryFixed,
          ),
          Space.w8,
        ],
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onTertiaryFixed,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
