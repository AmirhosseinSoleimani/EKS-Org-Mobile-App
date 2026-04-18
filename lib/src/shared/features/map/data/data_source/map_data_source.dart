import '../models/address_to_location_response_model.dart';
import '../models/location_to_address_response_model.dart';
import '../models/map_request_model.dart';

abstract class MapDataSource {
  Future<AddressToLocationResponseModel?> fetchAddressToLocation(
      MapRequestModel? model);

  Future<LocationToAddressResponseModel?> fetchLocationToAddress(
      MapRequestModel? model);
}
