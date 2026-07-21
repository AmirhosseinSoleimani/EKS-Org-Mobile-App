import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmergencyServiceButton extends StatelessWidget {
  const EmergencyServiceButton({
    super.key,
    required this.category,
    this.onTap,
    this.onDefects,
  });

  final EmdadServiceCategoryEntity category;
  final VoidCallback? onTap;
  final ValueChanged<int>? onDefects;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = category.isSelectedForVehicle;
    final primaryColor = theme.colorScheme.primary;
    final borderColor = selected ? primaryColor : const Color(0xFFE1E1E1);
    final foregroundColor = selected ? primaryColor : const Color(0xFF222222);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          height: AppSize.s48,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(
              color: borderColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: selected
              ? Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 18,
                      color: foregroundColor,
                    ),
                    Space.w8,
                    Expanded(
                      child: Text(
                        category.title,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: foregroundColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (onDefects != null) ...[
                      Space.w8,
                      GestureDetector(
                        onTap: () => onDefects!(category.id),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.settings_outlined,
                            size: 18,
                            color: foregroundColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              : Center(
                  child: Text(
                    category.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
