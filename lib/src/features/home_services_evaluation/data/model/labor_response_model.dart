

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';

import 'cost_center_model.dart';

class LaborResponseModel extends LaborResponseEntity {
  LaborResponseModel({
    super.allowableCostCenterList,
    super.code,
    super.companyPrice,
    super.customerPrice,
    super.garantyDurationLimitation,
    super.garantyKilometerLimitation,
    super.id,
    super.laborGroupId,
    super.laborGroupTitle,
    super.name,
    super.overlapCodes,
    super.standardTime,
    super.isImageMandatory,
    super.needImage,
  });

  factory LaborResponseModel.fromJson(Map<String, dynamic> json) {
    return LaborResponseModel(
      allowableCostCenterList: json['allowableCostCenterList'] != null ? (json['allowableCostCenterList'] as List).map((e) => CostCenterModel.fromJson(e)).toList() : [],
      code: json['code'],
      companyPrice: json['companyPrice'],
      customerPrice: json['customerPrice'],
      name: json['name'],
      id: json['id'],
      garantyDurationLimitation: json['garantyDurationLimitation'],
      garantyKilometerLimitation: json['garantyKilometerLimitation'],
      standardTime: json['standardTime'],
      overlapCodes: json['overLapCode'],
      laborGroupId: json['laborGroupId'],
      laborGroupTitle: json['laborGroupTitle'],
      isImageMandatory: json['isImageMandatory'],
      needImage: json['needImage'],

    );
  }
}