import 'package:eks_sana_plus_org/src/features/requests/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    super.cityName,
    super.provinceName,
    super.address,
    super.latitude,
    super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      cityName: json['cityName'],
      provinceName: json['provinceName'],
      address: json['address'],
      latitude: (json['latitude'] != null)
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: (json['longitude'] != null)
          ? double.tryParse(json['longitude'].toString())
          : null,
    );
  }
}
