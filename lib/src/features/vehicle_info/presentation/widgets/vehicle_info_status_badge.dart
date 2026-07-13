import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class VehicleInfoStatusBadge extends StatelessWidget {
  const VehicleInfoStatusBadge({
    super.key,
    required this.title,
    required this.isActive,
  });

  final String? title;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = isActive ?? title == 'فعال';
    final color = active ? Colors.green : theme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10, vertical: AppPadding.p4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Text(
        title?.trim().isNotEmpty == true ? title!.trim() : (active ? 'فعال' : 'غیرفعال'),
        style: theme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
