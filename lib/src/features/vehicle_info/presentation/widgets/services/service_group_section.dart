import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/emergency_service_button.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/local_service_chip.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ServiceGroupSection extends StatelessWidget {
  const ServiceGroupSection({
    super.key,
    required this.group,
    required this.onSelect,
    required this.onDefects,
  });

  final EmdadServiceCategoryGroupEntity group;
  final ValueChanged<int> onSelect;
  final ValueChanged<int>? onDefects;

  @override
  Widget build(BuildContext context) {
    final isEmergency = group.name.contains('امدادی');

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                _sectionIcon(group.name),
                size: AppSize.s20,
                color: const Color(0xFF777777),
              ),
              const SizedBox(width: 6),
              Text(
                group.name,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Space.h12,
          if (isEmergency)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: group.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3.8,
              ),
              itemBuilder: (context, index) {
                final category = group.categories[index];
                return EmergencyServiceButton(
                  category: category,
                  onTap: () => onSelect(category.id),
                  onDefects: onDefects,
                );
              },
            )
          else
            Wrap(
              alignment: WrapAlignment.start,
              spacing: AppSize.s8,
              runSpacing: 10,
              children: group.categories.map((category) {
                return LocalServiceChip(
                  category: category,
                  onTap: () => onSelect(category.id),
                  onDefects: onDefects,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  IconData _sectionIcon(String name) {
    if (name.contains('امدادی')) {
      return Icons.car_repair_outlined;
    }
    if (name.contains('محل')) {
      return Icons.business_center_outlined;
    }
    return Icons.miscellaneous_services_outlined;
  }
}
