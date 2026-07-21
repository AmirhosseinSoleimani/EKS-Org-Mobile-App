import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class LocalServiceChip extends StatelessWidget {
  const LocalServiceChip({
    super.key,
    required this.category,
    this.onDefects,
  });

  final EmdadServiceCategoryEntity category;
  final ValueChanged<int>? onDefects;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = category.isSelectedForVehicle;
    final color = selected ? theme.colorScheme.primary : const Color(0xFFE0E0E0);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: selected ? 1.6 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Icon(Icons.check_circle_outline_rounded, size: AppSize.s16, color: color),
              const SizedBox(width: 6),
            ],
            Text(
              category.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: selected ? color : const Color(0xFF202020),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (selected && onDefects != null) ...[
              Space.w8,
              Icon(Icons.settings_outlined, size: AppSize.s16, color: color),
              // onTap: () => onDefects!(category.id),
            ],
          ],
        ),
      ),
    );
  }
}
