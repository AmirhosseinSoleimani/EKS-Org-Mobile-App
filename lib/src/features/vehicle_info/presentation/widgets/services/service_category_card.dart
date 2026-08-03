import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_list_item.dart';
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
    final selected = category.isSelectedForVehicle;

    return SelectableListItem(
      title: category.title,
      selected: selected,
      onTap: onTap,
      suffix: selected && onDefects != null
          ? IconButton(
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
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
    );
  }
}
