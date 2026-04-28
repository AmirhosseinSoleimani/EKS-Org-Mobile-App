import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/data_source/map_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/area_base_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_to_address_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/map_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/network/network_state/result/api_result.dart';

@LazySingleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapDataSource _dataSource;

  MapRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<LocationToAddressResponseEntity?>> fetchLocationToAddress(
      MapRequestEntity? entity) async {
    try {
      final result =
          await _dataSource.fetchLocationToAddress(entity?.toModel());
      return ApiResult<LocationToAddressResponseEntity>.success(
          resultCode: 0,
          data: result?.toModel() ?? const LocationToAddressResponseEntity(),
          failures: []);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<AddressToLocationResponseEntity?>> fetchAddressToLocation(
      MapRequestEntity? entity) async {
    try {
      final result =
          await _dataSource.fetchAddressToLocation(entity?.toModel());
      return ApiResult<AddressToLocationResponseEntity>.success(
          resultCode: 0,
          data: result?.toModel() ?? const AddressToLocationResponseEntity(),
          failures: []);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<RouteDataEntity>> getRoute(RouteParamEntity param) async {
    try {
      final result = await _dataSource.getRoute(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<AreaBaseEntity>> getAreaBaseData() async {
    try {
      final result = await _dataSource.getAreaBaseData();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
