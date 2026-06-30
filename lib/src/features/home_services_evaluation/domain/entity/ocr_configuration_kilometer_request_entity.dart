import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/ocr_configuration_kilometer_request_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class OcrConfigurationKilometerRequestEntity {
  final int? serviceType;

  const OcrConfigurationKilometerRequestEntity({this.serviceType});

  OcrConfigurationKilometerRequestEntity copyWith({int? serviceType}) {
    return OcrConfigurationKilometerRequestEntity(
      serviceType: serviceType ?? this.serviceType,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OcrConfigurationKilometerRequestEntity &&
          other.serviceType == serviceType;

  @override
  int get hashCode => serviceType.hashCode;

  OcrConfigurationKilometerRequestModel toModel() {
    return OcrConfigurationKilometerRequestModel(serviceType: serviceType);
  }
}
