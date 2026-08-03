import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:flutter/material.dart';

@Deprecated('Use SelectedItemsSection instead.')
class SelectedVehicleDefectsSection extends StatelessWidget {
  const SelectedVehicleDefectsSection({
    super.key,
    required this.items,
    required this.onRemove,
  });

  final List<EmdadServiceCategoryEntity> items;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    return SelectedItemsSection<EmdadServiceCategoryEntity>(
      title: 'سرویس های انتخاب شده',
      items: items,
      itemTitle: (category) => category.title,
      onRemove: (category) => onRemove(category.id),
    );
  }
}
