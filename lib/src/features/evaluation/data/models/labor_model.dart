import '../../domain/entities/labor_entity.dart';
import 'allowable_cost_center_model.dart';

class LaborModel extends LaborEntity {
  const LaborModel({
    super.id,
    super.name,
    super.companyPrice,
    super.customerPrice,
    super.code,
    super.allowableCostCenterList,
    super.garantyDurationDayLimitation,
    super.garantyKilometerLimitation,
    super.overLapCode,
    super.standardTime,
    super.laborGroupId,
    super.laborGroupTitle,
    super.needImage,
    super.isImageMandatory,
  });

  factory LaborModel.fromJson(Map<String, dynamic> json) {
    return LaborModel(
      id: json['id'],
      name: json['name'],
      companyPrice: json['companyPrice'],
      customerPrice: json['customerPrice'],
      code: json['code'],
      allowableCostCenterList: json['allowableCostCenterList'] == null
          ? null
          : (json['allowableCostCenterList'] as List)
          .map((e) => AllowableCostCenterModel.fromJson(e).toEntity())
          .toList(),
      garantyDurationDayLimitation: json['garantyDurationDayLimitation'],
      garantyKilometerLimitation: json['garantyKilometerLimitation'],
      overLapCode: json['overLapCode'],
      standardTime: (json['standardTime'] as num?)?.toDouble(),
      laborGroupId: json['laborGroupId'],
      laborGroupTitle: json['laborGroupTitle'],
      needImage: json['needImage'],
      isImageMandatory: json['isImageMandatory'],
    );
  }
}