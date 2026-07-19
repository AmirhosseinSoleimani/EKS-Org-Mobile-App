import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadUnitStatusBadge extends StatelessWidget {
  const EmdadUnitStatusBadge({super.key, required this.isActive});

  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    final active = isActive == true;
    final theme = Theme.of(context);
    final background = active
        ? theme.colorScheme.onError.withValues(alpha: 0.10)
        : theme.colorScheme.error.withValues(alpha: 0.10);
    final foreground = active ? const Color(0xFF1B6D24) : theme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Text(
        active ? 'فعال' : 'غیرفعال',
        style: theme.textTheme.bodySmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
