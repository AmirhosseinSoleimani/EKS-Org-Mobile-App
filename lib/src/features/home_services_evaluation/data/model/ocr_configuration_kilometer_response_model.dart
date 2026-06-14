import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_response_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class OcrConfigurationKilometerResponseModel extends OcrConfigurationKilometerResponseEntity {
  const OcrConfigurationKilometerResponseModel({
    super.isSavingImageMandatory,
    super.isKilometerInputEnabled,
  });

  OcrConfigurationKilometerResponseEntity toEntity() {
    return OcrConfigurationKilometerResponseEntity(
      isSavingImageMandatory: isSavingImageMandatory,
      isKilometerInputEnabled: isKilometerInputEnabled,
    );
  }

  factory OcrConfigurationKilometerResponseModel.fromJson(Map<String, dynamic> json) {
    return OcrConfigurationKilometerResponseModel(
      isSavingImageMandatory: json['isSavingImageMandatory'],
      isKilometerInputEnabled: json['isKilometerInputEnabled'],
    );
  }
}