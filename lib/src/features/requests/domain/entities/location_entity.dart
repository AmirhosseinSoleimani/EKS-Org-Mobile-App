import 'package:eks_sana_plus_org/src/features/requests/data/models/location_model.dart';

class LocationEntity {
  final String? cityName;
  final String? provinceName;
  final String? address;
  final double? latitude;
  final double? longitude;

  LocationEntity({
    this.cityName,
    this.provinceName,
    this.address,
    this.latitude,
    this.longitude,
  });

  LocationEntity copyWith({
    String? cityName,
    String? provinceName,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return LocationEntity(
      cityName: cityName ?? this.cityName,
      provinceName: provinceName ?? this.provinceName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  LocationModel toModel() {
    return LocationModel(
      cityName: cityName,
      provinceName: provinceName,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
