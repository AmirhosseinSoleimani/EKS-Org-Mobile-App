import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoStatusBadge extends StatelessWidget {
  const AgencyInfoStatusBadge({
    super.key,
    required this.isActive,
  });

  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = isActive == true;
    final color = active ? Colors.green : theme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Text(
        active ? 'فعال' : 'غیرفعال',
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
