import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/kilometer_from_image_request_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class KilometerFromImageRequestEntity {
  final int? serviceType;
  final String? imageBase64;

  const KilometerFromImageRequestEntity({this.serviceType, this.imageBase64});

  KilometerFromImageRequestEntity copyWith({
    int? serviceType,
    String? imageBase64,
  }) {
    return KilometerFromImageRequestEntity(
      serviceType: serviceType ?? this.serviceType,
      imageBase64: imageBase64 ?? this.imageBase64,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KilometerFromImageRequestEntity &&
          runtimeType == other.runtimeType &&
          other.serviceType == serviceType &&
          other.imageBase64 == imageBase64;

  @override
  int get hashCode => Object.hash(serviceType, imageBase64);

  KilometerFromImageRequestModel toModel() {
    return KilometerFromImageRequestModel(
      serviceType: serviceType,
      imageBase64: imageBase64,
    );
  }
}
