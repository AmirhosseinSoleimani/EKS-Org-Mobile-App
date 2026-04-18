import 'package:injectable/injectable.dart';

import '../models/address_to_location_response_model.dart';
import '../models/location_to_address_response_model.dart';
import '../models/map_request_model.dart';
import '../service/map_service.dart';
import 'map_data_source.dart';

@LazySingleton(as: MapDataSource)
class MapDataSourceImpl extends MapDataSource {
  final MapService _service;

  MapDataSourceImpl(this._service);

  @override
  Future<LocationToAddressResponseModel?> fetchLocationToAddress(
      MapRequestModel? model) async {
    final result =
        await _service.fetchLocationToAddress('${model?.lon},${model?.lat}');
    return result;
  }

  @override
  Future<AddressToLocationResponseModel?> fetchAddressToLocation(
      MapRequestModel? model) async {
    final result = await _service.fetchAddressToLocation(
        model?.text ?? '', '${model?.lon},${model?.lat}');
    return result;
  }
}
