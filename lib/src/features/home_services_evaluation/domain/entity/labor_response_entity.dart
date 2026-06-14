import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/labor_response_model.dart';

import 'cost_center_entity.dart';

class LaborResponseEntity {
  String? name;
  int? id;
  String? companyPrice;
  String? customerPrice;
  String? code;
  List<CostCenterEntity>? allowableCostCenterList;
  int? garantyDurationLimitation;
  int? garantyKilometerLimitation;
  String? overlapCodes;
  double? standardTime;
  int? laborGroupId;
  String? laborGroupTitle;
  bool? needImage;
  bool? isImageMandatory;

  LaborResponseEntity({
    this.laborGroupId,
    this.name,
    this.standardTime,
    this.id,
    this.companyPrice,
    this.customerPrice,
    this.code,
    this.allowableCostCenterList,
    this.overlapCodes,
    this.garantyDurationLimitation,
    this.garantyKilometerLimitation,
    this.laborGroupTitle,
    this.isImageMandatory,
    this.needImage,
  });

  LaborResponseEntity copyWith({
    String? name,
    int? id,
    String? companyPrice,
    String? customerPrice,
    String? code,
    List<CostCenterEntity>? allowableCostCenterList,
    int? garantyDurationLimitation,
    int? garantyKilometerLimitation,
    String? overlapCodes,
    double? standardTime,
    int? laborGroupId,
    String? laborGroupTitle,
    bool? needImage,
    bool? isImageMandatory,
  }) {
    return LaborResponseEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      companyPrice: companyPrice ?? this.companyPrice,
      customerPrice: customerPrice ?? this.customerPrice,
      code: code ?? this.code,
      allowableCostCenterList:
          allowableCostCenterList ?? this.allowableCostCenterList,
      garantyDurationLimitation:
          garantyDurationLimitation ?? this.garantyDurationLimitation,
      garantyKilometerLimitation:
          garantyKilometerLimitation ?? this.garantyKilometerLimitation,
      overlapCodes: overlapCodes ?? this.overlapCodes,
      standardTime: standardTime ?? this.standardTime,
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborGroupTitle: laborGroupTitle ?? this.laborGroupTitle,
      needImage: needImage ?? this.needImage,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }

  LaborResponseModel toModel() {
    return LaborResponseModel(
      laborGroupId: laborGroupId,
      name: name,
      standardTime: standardTime,
      id: id,
      companyPrice: companyPrice,
      customerPrice: customerPrice,
      laborGroupTitle: laborGroupTitle,
      garantyDurationLimitation: garantyDurationLimitation,
      garantyKilometerLimitation: garantyKilometerLimitation,
      code: code,
      allowableCostCenterList: allowableCostCenterList
          ?.map((e) => e.toModel())
          .toList(),
      overlapCodes: overlapCodes,
      needImage: needImage,
      isImageMandatory: isImageMandatory,
    );
  }
}
