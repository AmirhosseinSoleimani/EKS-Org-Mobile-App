import '../../data/models/labor_model.dart';
import 'allowable_cost_center_entity.dart';

class LaborEntity {
  final int? id;
  final String? name;
  final String? companyPrice;
  final String? customerPrice;
  final String? code;
  final List<AllowableCostCenterEntity>? allowableCostCenterList;
  final int? garantyDurationDayLimitation;
  final int? garantyKilometerLimitation;
  final String? overLapCode;
  final double? standardTime;
  final int? laborGroupId;
  final String? laborGroupTitle;
  final bool? needImage;
  final bool? isImageMandatory;

  const LaborEntity({
    this.id,
    this.name,
    this.companyPrice,
    this.customerPrice,
    this.code,
    this.allowableCostCenterList,
    this.garantyDurationDayLimitation,
    this.garantyKilometerLimitation,
    this.overLapCode,
    this.standardTime,
    this.laborGroupId,
    this.laborGroupTitle,
    this.needImage,
    this.isImageMandatory,
  });

  LaborModel toModel() {
    return LaborModel(
      id: id,
      name: name,
      companyPrice: companyPrice,
      customerPrice: customerPrice,
      code: code,
      allowableCostCenterList:
      allowableCostCenterList?.map((e) => e.toModel()).toList(),
      garantyDurationDayLimitation: garantyDurationDayLimitation,
      garantyKilometerLimitation: garantyKilometerLimitation,
      overLapCode: overLapCode,
      standardTime: standardTime,
      laborGroupId: laborGroupId,
      laborGroupTitle: laborGroupTitle,
      needImage: needImage,
      isImageMandatory: isImageMandatory,
    );
  }

  LaborEntity copyWith({
    int? id,
    String? name,
    String? companyPrice,
    String? customerPrice,
    String? code,
    List<AllowableCostCenterEntity>? allowableCostCenterList,
    int? garantyDurationDayLimitation,
    int? garantyKilometerLimitation,
    String? overLapCode,
    double? standardTime,
    int? laborGroupId,
    String? laborGroupTitle,
    bool? needImage,
    bool? isImageMandatory,
  }) {
    return LaborEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      companyPrice: companyPrice ?? this.companyPrice,
      customerPrice: customerPrice ?? this.customerPrice,
      code: code ?? this.code,
      allowableCostCenterList:
      allowableCostCenterList ?? this.allowableCostCenterList,
      garantyDurationDayLimitation:
      garantyDurationDayLimitation ?? this.garantyDurationDayLimitation,
      garantyKilometerLimitation:
      garantyKilometerLimitation ?? this.garantyKilometerLimitation,
      overLapCode: overLapCode ?? this.overLapCode,
      standardTime: standardTime ?? this.standardTime,
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborGroupTitle: laborGroupTitle ?? this.laborGroupTitle,
      needImage: needImage ?? this.needImage,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }
}