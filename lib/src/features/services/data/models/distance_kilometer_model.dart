import 'package:eks_sana_plus_org/src/features/services/domain/entities/distance_kilometer_entity.dart';

class DistanceKilometerModel extends DistanceKilometerEntity {
  const DistanceKilometerModel({
    super.distanceKilometer,
    super.isDistanceKilometerEditable,
  });

  factory DistanceKilometerModel.fromJson(Map<String, dynamic> json) {
    return DistanceKilometerModel(
      distanceKilometer: (json['distanceKilometer'] as num?)?.toDouble(),
      isDistanceKilometerEditable:
      json['isDistanceKilometerEditable'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distanceKilometer': distanceKilometer,
      'isDistanceKilometerEditable': isDistanceKilometerEditable,
    };
  }
}
