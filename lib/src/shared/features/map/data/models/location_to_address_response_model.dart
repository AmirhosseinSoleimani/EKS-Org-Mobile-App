import '../../domain/entity/location_to_address_response_entity.dart';

class LocationToAddressResponseModel extends LocationToAddressResponseEntity {
  const LocationToAddressResponseModel({
    super.address,
    super.certainty,
    super.geoFences,
    super.status,
    super.subdivisionPrefix,
    super.subDivPrefixedAddress,
  });

  factory LocationToAddressResponseModel.fromJson(Map<String, dynamic> json) {
    return LocationToAddressResponseModel(
      address: json['address'],
      certainty: json['certainty'],
      geoFences: json['geofences'],
      status: json['status'],
      subdivisionPrefix: json['local_address'],
      subDivPrefixedAddress: json['subdiv_prefixed_address'],
    );
  }
}
