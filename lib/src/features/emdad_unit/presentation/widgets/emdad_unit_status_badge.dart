import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadUnitStatusBadge extends StatelessWidget {
  const EmdadUnitStatusBadge({super.key, required this.isActive});

  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    final active = isActive ?? false;
    final colorScheme = Theme.of(context).colorScheme;
    final color = active ? colorScheme.primary : colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        active ? 'فعال' : 'غیرفعال',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
      ),
    );
  }
}
