import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/ocr_configuration_kilometer_response_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class OcrConfigurationKilometerResponseEntity {
  final bool? isSavingImageMandatory;
  final bool? isKilometerInputEnabled;

  const OcrConfigurationKilometerResponseEntity({
    this.isSavingImageMandatory,
    this.isKilometerInputEnabled,
  });

  OcrConfigurationKilometerResponseEntity copyWith({
    bool? isSavingImageMandatory,
    bool? isKilometerInputEnabled,
  }) {
    return OcrConfigurationKilometerResponseEntity(
      isSavingImageMandatory:
          isSavingImageMandatory ?? this.isSavingImageMandatory,
      isKilometerInputEnabled:
          isKilometerInputEnabled ?? this.isKilometerInputEnabled,
    );
  }

  OcrConfigurationKilometerResponseModel toModel() {
    return OcrConfigurationKilometerResponseModel(
      isSavingImageMandatory: isSavingImageMandatory,
      isKilometerInputEnabled: isKilometerInputEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OcrConfigurationKilometerResponseEntity &&
          runtimeType == other.runtimeType &&
          other.isSavingImageMandatory == isSavingImageMandatory &&
          other.isKilometerInputEnabled == isKilometerInputEnabled;

  @override
  int get hashCode =>
      Object.hash(isSavingImageMandatory, isKilometerInputEnabled);
}
