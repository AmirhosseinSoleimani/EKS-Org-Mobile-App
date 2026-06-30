import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_model.dart';

class LocationEntity {
  final double latitude;
  final double longitude;

  LocationEntity({required this.latitude, required this.longitude});

  LocationEntity copyWith({double? latitude, double? longitude}) {
    return LocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  LocationModel toModel() {
    return LocationModel(latitude: latitude, longitude: longitude);
  }
}
