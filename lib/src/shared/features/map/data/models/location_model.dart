import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required super.latitude, required super.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toLocationRequestJson() {
    return {'location': toJson()};
  }

  Map<String, dynamic> toJson() {
    return {'longitude': longitude, 'latitude': latitude};
  }
}
