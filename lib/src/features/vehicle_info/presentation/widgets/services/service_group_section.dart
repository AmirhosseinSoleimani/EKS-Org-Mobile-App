import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_group_header.dart';
import 'package:flutter/material.dart';

class ServiceGroupSection extends StatelessWidget {
  const ServiceGroupSection({
    super.key,
    required this.group,
    required this.onSelect,
    required this.onDefects,
  });

  final EmdadServiceCategoryGroupEntity group;
  final ValueChanged<int>? onSelect;
  final ValueChanged<int>? onDefects;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (group.name.trim().isNotEmpty) ...[
            SelectionGroupHeader(
              title: group.name,
              icon: _groupIcon(group.name),
            ),
            Space.h12,
          ],
          ...group.categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p8),
              child: ServiceCategoryCard(
                category: category,
                onTap: onSelect == null
                    ? null
                    : () => onSelect!(category.id),
                onDefects: onDefects,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _groupIcon(String title) {
    if (title.contains('امدادی')) return Icons.car_repair_outlined;
    if (title.contains('محل')) return Icons.home_repair_service_outlined;
    return Icons.miscellaneous_services_outlined;
  }
}
