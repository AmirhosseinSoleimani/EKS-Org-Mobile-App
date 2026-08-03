import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ServiceCategoryCard extends StatelessWidget {
  const ServiceCategoryCard({
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

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          constraints: const BoxConstraints(minHeight: AppSize.s60),
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppPadding.p10,
            AppPadding.p10,
            AppPadding.p14,
            AppPadding.p10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? primaryColor.withOpacity(0.08)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSize.s12),
            border: Border.all(
              color: selected
                  ? primaryColor.withOpacity(0.45)
                  : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(selected ? 0.0 : 0.025),
                blurRadius: AppSize.s8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: AppSize.s28,
                height: AppSize.s28,
                child: Checkbox(
                  value: selected,
                  onChanged: onTap == null ? null : (_) => onTap!(),
                  activeColor: primaryColor,
                  checkColor: theme.colorScheme.onPrimary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: BorderSide(
                    color: primaryColor,
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s6),
                  ),
                ),
              ),
              Space.w12,
              Expanded(
                child: Text(
                  category.title,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF3E3E3E),
                    fontWeight: FontWeight.w500,
                    height: 1.55,
                  ),
                ),
              ),
              if (selected && onDefects != null) ...[
                Space.w8,
                IconButton(
                  onPressed: () => onDefects!(category.id),
                  tooltip: 'محدودیت عیوب',
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: AppSize.s32,
                    minHeight: AppSize.s32,
                  ),
                  icon: Icon(
                    Icons.settings_outlined,
                    size: AppSize.s20,
                    color: primaryColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
