import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/area_base_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/param/route_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/service/route_service.dart';
import 'package:injectable/injectable.dart';

import '../models/address_to_location_response_model.dart';
import '../models/location_to_address_response_model.dart';
import '../models/map_request_model.dart';
import '../service/map_service.dart';
import 'map_data_source.dart';

@LazySingleton(as: MapDataSource)
class MapDataSourceImpl extends MapDataSource {
  final MapService _service;
  final RouteService roteService;

  MapDataSourceImpl(this._service, this.roteService);

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

  @override
  Future<BaseSingleResponse<RouteDataModel>> getRoute(RouteParamModel param) async {
    return await roteService.getRoute(param.toJson());
  }

  @override
  Future<BaseSingleResponse<AreaBaseModel>> getAreaBaseData() async{
    return await roteService.getAreaBaseData({});
  }
}
