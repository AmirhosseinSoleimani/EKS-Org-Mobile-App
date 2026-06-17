import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';

extension EvaluationLaborResponseMapper on EvaluationLaborResponseEntity {
  EvaluationSelectedLaborEntity toSelectedEntity() {
    return EvaluationSelectedLaborEntity(
      labor: _mapLabor(),
      costCenter: _mapCostCenter(),
      price: laborPrice ?? 0,
      evaluationParts: parts?.map((part) => part.toSelectedEntity()).toList() ?? [],
    );
  }

  LaborEntity _mapLabor() {
    return LaborEntity(
      id: laborId,
      name: laborGroupDesc,
      code: laborCode,
      laborGroupId: laborGroupId,
      laborGroupTitle: laborName,
      standardTime: standardTime,
      overLapCode: overlapCodes,
      needImage: needImage,
      isImageMandatory: isImageMandatory,
    );
  }

  AllowableCostCenterEntity _mapCostCenter() {
    final costCenter = costCenterObject ?? (costCenterList?.isNotEmpty == true
        ? costCenterList!.first
        : null);

    return AllowableCostCenterEntity(
      id: costCenter?.id,
      name: costCenter?.name,
      code: costCenter?.code,
      selected: true,
    );
  }
}

extension EvaluationPartResponseMapper on EvaluationPartResponseEntity {
  EvaluationSelectedPartEntity toSelectedEntity() {
    return EvaluationSelectedPartEntity(
      part: PartEntity(
        id: laborId,
        name: partName,
      ),
      mark: PartMarkEntity(
        mark: mark,
      ),
      costCenter: costCenterObject != null
          ? AllowableCostCenterEntity(
        id: costCenterObject!.id,
        name: costCenterObject!.name,
        code: costCenterObject!.code,
      )
          : const AllowableCostCenterEntity(),
      count: count ?? 0,
      price: partPrice ?? 0,
      hasReusable: hasReusable ?? false,
      isReusable: isReusable ?? false,
      isCausing: isCausing ?? false,
    );
  }
}