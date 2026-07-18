import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionSheetItem extends StatelessWidget {
  const AgencyInfoActionSheetItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.onPrimaryFixed;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color, size: AppSize.s24),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: onTap,
    );
  }
}
