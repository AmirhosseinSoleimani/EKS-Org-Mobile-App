import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_request_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class KilometerFromImageRequestModel extends KilometerFromImageRequestEntity{
  const KilometerFromImageRequestModel({
    super.imageBase64,
    super.serviceType,
  });

  KilometerFromImageRequestEntity toEntity() {
    return KilometerFromImageRequestEntity(
      serviceType: serviceType,
      imageBase64: imageBase64,
    );
  }


  Map<String, dynamic> toJson() => <String, dynamic>{
    'serviceType': serviceType,
    'ImageBase64': imageBase64,
  };
}