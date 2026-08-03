import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_card.dart';
import 'package:flutter/material.dart';

@Deprecated('Use ServiceCategoryCard instead.')
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
    return ServiceCategoryCard(
      category: category,
      onTap: onTap,
      onDefects: onDefects,
    );
  }
}
