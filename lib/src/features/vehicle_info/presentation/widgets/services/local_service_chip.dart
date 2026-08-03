import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_check_item.dart';
import 'package:flutter/material.dart';

@Deprecated('Use SelectableCheckItem instead.')
class LocalServiceChip extends StatelessWidget {
  const LocalServiceChip({
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

    return SelectableCheckItem(
      title: category.title,
      selected: selected,
      onTap: onTap,
      suffix: selected && onDefects != null
          ? IconButton(
              onPressed: () => onDefects!(category.id),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                Icons.settings_outlined,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
    );
  }
}
