
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_to_address_response_model.dart';

class LocationToAddressResponseEntity {
  const LocationToAddressResponseEntity({
    this.address,
    this.subdivisionPrefix,
    this.subDivPrefixedAddress,
    this.certainty,
    this.status,
    this.geoFences,
  });

  final String? address;
  final String? subdivisionPrefix;
  final String? subDivPrefixedAddress;
  final List<dynamic>? geoFences;
  final String? status;
  final int? certainty;

  LocationToAddressResponseModel toModel() {
    return LocationToAddressResponseModel(
        address: address,
        subdivisionPrefix: subdivisionPrefix,
        subDivPrefixedAddress: subDivPrefixedAddress,
        geoFences: geoFences,
        status: status,
        certainty: certainty

    );
  }
}