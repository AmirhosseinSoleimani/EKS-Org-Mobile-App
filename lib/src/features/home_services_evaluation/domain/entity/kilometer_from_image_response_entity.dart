import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/kilometer_from_image_response_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class KilometerFromImageResponseEntity {
  final int? kilometer;
  final bool? isKilometerInputEnabled;

  const KilometerFromImageResponseEntity({
    this.kilometer,
    this.isKilometerInputEnabled,
  });

  KilometerFromImageResponseEntity copyWith({
    int? kilometer,
    bool? isKilometerInputEnabled,
  }) {
    return KilometerFromImageResponseEntity(
      kilometer: kilometer ?? this.kilometer,
      isKilometerInputEnabled:
          isKilometerInputEnabled ?? this.isKilometerInputEnabled,
    );
  }

  KilometerFromImageResponseModel toModel() {
    return KilometerFromImageResponseModel(
      kilometer: kilometer,
      isKilometerInputEnabled: isKilometerInputEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KilometerFromImageResponseEntity &&
          runtimeType == other.runtimeType &&
          other.kilometer == kilometer &&
          other.isKilometerInputEnabled == isKilometerInputEnabled;

  @override
  int get hashCode => Object.hash(kilometer, isKilometerInputEnabled);
}
