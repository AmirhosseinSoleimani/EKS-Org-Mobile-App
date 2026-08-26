import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/data_source/map_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/area_base_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/discountable_area_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_data_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_to_address_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/map_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/area_base_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  MapRepositoryImpl(this._dataSource);

  final MapDataSource _dataSource;

  @override
  Future<ApiResult<LocationToAddressResponseEntity?>> fetchLocationToAddress(
    MapRequestEntity? entity,
  ) async {
    try {
      final result = await _dataSource.fetchLocationToAddress(entity?.toModel());
      return ApiResult<LocationToAddressResponseEntity>.success(
        resultCode: 0,
        data: result?.toModel() ?? const LocationToAddressResponseEntity(),
        failures: const [],
      );
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AddressToLocationResponseEntity?>> fetchAddressToLocation(
    MapRequestEntity? entity,
  ) async {
    try {
      final result = await _dataSource.fetchAddressToLocation(entity?.toModel());
      return ApiResult<AddressToLocationResponseEntity>.success(
        resultCode: 0,
        data: result?.toModel() ?? const AddressToLocationResponseEntity(),
        failures: const [],
      );
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<RouteDataEntity>> getRoute(RouteParamEntity param) async {
    try {
      return (await _dataSource.getRoute(param.toModel())).toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<AreaBaseEntity>>> getAreaBaseData(
    AreaBaseInfoParamEntity param,
  ) async {
    try {
      return (await _dataSource.getAreaBaseData(param.toModel()))
          .toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<ProvinceEntity>>> getProvinceList() async {
    try {
      return (await _dataSource.getProvinceList()).toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<ProvinceLookupEntity>>>
      getProvinceLookupList() async {
    try {
      return (await _dataSource.getProvinceLookupList()).toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<DiscountableAreaEntity>>>
      getDiscountableAreas() async {
    try {
      return (await _dataSource.getDiscountableAreas()).toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<LocationDataEntity>> getLocationData(
    LocationEntity param,
  ) async {
    try {
      return (await _dataSource.getLocationData(param.toModel())).toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
