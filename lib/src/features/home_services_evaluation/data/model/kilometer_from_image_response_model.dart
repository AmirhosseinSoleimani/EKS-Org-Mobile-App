import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_response_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
class KilometerFromImageResponseModel extends KilometerFromImageResponseEntity {
  const KilometerFromImageResponseModel({
    super.kilometer,
    super.isKilometerInputEnabled,
  });

  KilometerFromImageResponseEntity toEntity() {
    return KilometerFromImageResponseEntity(
      kilometer: kilometer,
      isKilometerInputEnabled: isKilometerInputEnabled,
    );
  }

  factory KilometerFromImageResponseModel.fromJson(Map<String, dynamic> json) {
    return KilometerFromImageResponseModel(
        kilometer: json['kilometer'],
        isKilometerInputEnabled: json['isKilometerInputEnabled'],
    );
  }
}