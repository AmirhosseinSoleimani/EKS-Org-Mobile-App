
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/area_base_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_data_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_to_address_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/map_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';

abstract class MapRepository {
  Future<ApiResult<AddressToLocationResponseEntity?>> fetchAddressToLocation(MapRequestEntity? entity);
  Future<ApiResult<LocationToAddressResponseEntity?>> fetchLocationToAddress(MapRequestEntity? entity);
  Future<ApiResult<RouteDataEntity>> getRoute(RouteParamEntity param);
  Future<ApiResult<AreaBaseEntity>> getAreaBaseData();

  Future<ApiResult<List<ProvinceEntity>>> getProvinceList();

  Future<ApiResult<LocationDataEntity>> getLocationData(LocationEntity param);
}
