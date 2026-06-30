import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_labor_entity.dart';

class InsertHomeServiceLaborModel extends InsertHomeServiceLaborEntity {
  const InsertHomeServiceLaborModel({
    super.laborCode,
    super.costCenter,
    super.laborDesc,
    super.laborGroupId,
    super.laborId,
    super.laborPrice,
    super.serviceId,
    super.parts,
    super.isMandatory,
    super.isImageMandatory,
  });

  Map<String, dynamic> toJson() {
    return {
      'laborId': laborId,
      'laborGroupId': laborGroupId,
      'laborDesc': laborDesc,
      'laborCode': laborCode,
      'laborPrice': laborPrice,
      'serviceId': serviceId,
      'isMandatory': isMandatory,
      'isImageMandatory': isImageMandatory,
      'laborCostCenter': costCenter?.toModel().toJson(),
      'parts': parts?.map((e) => e.toModel().toJson()).toList(),
    };
  }
}
