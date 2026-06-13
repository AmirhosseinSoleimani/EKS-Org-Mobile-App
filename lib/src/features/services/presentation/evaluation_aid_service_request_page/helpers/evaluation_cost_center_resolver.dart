import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';

class EvaluationCostCenterResolver {
  EvaluationCostCenterResolver._();

  static AllowableCostCenterEntity? findDefault(
    List<AllowableCostCenterEntity> items,
  ) {
    if (items.isEmpty) return null;

    return items.firstWhere(
      (item) => item.selected == true,
      orElse: () => items.first,
    );
  }

  static AllowableCostCenterEntity? findMatching({
    required List<AllowableCostCenterEntity> costCenters,
    required AllowableCostCenterEntity previousCostCenter,
  }) {
    if (costCenters.isEmpty) return null;

    final previousId = previousCostCenter.id;
    final previousCode = previousCostCenter.code;

    for (final item in costCenters) {
      final sameId = previousId != null && item.id == previousId;
      final sameCode = previousCode != null && item.code == previousCode;

      if (sameId || sameCode) return item;
    }

    return findDefault(costCenters);
  }

  static String resolveLaborPrice({
    required LaborEntity labor,
    required AllowableCostCenterEntity costCenter,
  }) {
    switch (costCenter.code) {
      case 'Company':
      case 'Garanty':
        return labor.companyPrice ?? '0';
      case 'Customer':
      default:
        return labor.customerPrice ?? '0';
    }
  }
}
