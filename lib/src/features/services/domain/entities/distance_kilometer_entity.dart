import 'package:eks_sana_plus_org/src/features/services/data/models/distance_kilometer_model.dart';

class DistanceKilometerEntity {
  final double? distanceKilometer;
  final bool? isDistanceKilometerEditable;

  const DistanceKilometerEntity({
    this.distanceKilometer,
    this.isDistanceKilometerEditable,
  });

  DistanceKilometerModel toModel() {
    return DistanceKilometerModel(
      distanceKilometer: distanceKilometer,
      isDistanceKilometerEditable: isDistanceKilometerEditable,
    );
  }

  DistanceKilometerEntity copyWith({
    double? distanceKilometer,
    bool? isDistanceKilometerEditable,
  }) {
    return DistanceKilometerEntity(
      distanceKilometer: distanceKilometer ?? this.distanceKilometer,
      isDistanceKilometerEditable:
      isDistanceKilometerEditable ?? this.isDistanceKilometerEditable,
    );
  }
}
