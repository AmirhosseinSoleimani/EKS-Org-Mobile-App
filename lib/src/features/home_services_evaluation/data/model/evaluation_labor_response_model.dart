import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'evaluation_part_response_model.dart';

class EvaluationLaborResponseModel extends EvaluationLaborResponseEntity {
  EvaluationLaborResponseModel({
    super.costCenterObject,
    super.laborCode,
    super.costCenterList,
    super.laborId,
    super.laborGroupId,
    super.laborPrice,
    super.laborName,
    super.overlapCodes,
    super.parts,
    super.standardTime,
    super.isCausing,
    super.laborGroupDesc,
    super.needImage,
    super.isImageMandatory,
  });

  factory EvaluationLaborResponseModel.fromJson(dynamic json) {
    return EvaluationLaborResponseModel(
      laborGroupId: json['laborGroupId'],
      laborGroupDesc: json['laborGroupDesc'],
      laborId: json['laborId'],
      laborCode: json['laborCode'],
      laborName: json['name'],
      standardTime: (json['standardTime'] as num?)?.toDouble(),
      laborPrice: json['price'],
      isCausing: json['isCausing'],
      overlapCodes: json['overLapCode'],
      isImageMandatory: json['isImageMandatory'],
      costCenterList: json['allowableCostCenterList'] != null ? (json['allowableCostCenterList'] as List).map((e) => CostCenterModel.fromJson(e)).toList() : null,
      costCenterObject: json['costCenter'] != null ? CostCenterModel.fromJson(json['costCenter']) : null,
      parts: json['evaluationParts'] != null ? (json['evaluationParts'] as List).map((e) => EvaluationPartResponseModel.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = laborName;
    map['laborGroupDesc'] = laborGroupDesc;
    map['laborGroupId'] = laborGroupId;
    map['laborId'] = laborId;
    map['isCausing'] = isCausing;
    map['standardTime'] = standardTime;
    map['laborCode'] = laborCode;
    map['allowableCostCenterList'] = costCenterList;
    map['costCenter'] = costCenterObject?.toModel().toJson();
    map['overLapCode'] = overlapCodes;
    map['price'] = laborPrice;
    map['needImage'] = needImage;
    map['evaluationParts'] = parts?.map((e) => e.toModel().toJson()).toList();
    return map;
  }
}