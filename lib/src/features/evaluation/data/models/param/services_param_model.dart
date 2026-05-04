import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_param_entity.dart';

class ServicesParamModel extends ServicesParamEntity {
  const ServicesParamModel({
    required super.serviceType,
    required super.defectId,
    required super.nationalCode,
    required super.kilometer,
    required super.carInfoGuid,
    required super.carModelId,
  });

  Map<String, dynamic> toJson() {
    return {
      'ServiceType': serviceType,
      'defectId': defectId,
      'nationalCode': nationalCode,
      'kilometer': kilometer,
      'carInfoGuid': carInfoGuid,
      'carModelId': carModelId,
    };
  }
}
