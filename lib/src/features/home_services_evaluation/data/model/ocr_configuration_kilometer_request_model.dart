import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_request_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class OcrConfigurationKilometerRequestModel extends OcrConfigurationKilometerRequestEntity{
  const OcrConfigurationKilometerRequestModel({
    super.serviceType,
  });

  OcrConfigurationKilometerRequestEntity toEntity() {
    return OcrConfigurationKilometerRequestEntity(
      serviceType: serviceType,
    );
  }


  Map<String, dynamic> toJson() => <String, dynamic>{
    'serviceType': serviceType,
  };
}