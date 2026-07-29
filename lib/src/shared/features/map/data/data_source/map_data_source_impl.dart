import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/data_source/map_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/address_to_location_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/area_base_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/discountable_area_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_data_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_to_address_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/map_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/param/area_base_info_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/param/route_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/province_lookup_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/province_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/service/address_service.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/service/map_lookup_service.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/service/map_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MapDataSource)
class MapDataSourceImpl extends MapDataSource {
  MapDataSourceImpl(
    this._service,
    this._addressService,
    this._lookupService,
  );

  final MapService _service;
  final AddressService _addressService;
  final MapLookupService _lookupService;

  @override
  Future<LocationToAddressResponseModel?> fetchLocationToAddress(
    MapRequestModel? model,
  ) => _service.fetchLocationToAddress('${model?.lon},${model?.lat}');

  @override
  Future<AddressToLocationResponseModel?> fetchAddressToLocation(
    MapRequestModel? model,
  ) => _service.fetchAddressToLocation(
        model?.text ?? '',
        '${model?.lon},${model?.lat}',
      );

  @override
  Future<BaseSingleResponse<RouteDataModel>> getRoute(
    RouteParamModel param,
  ) => _addressService.getRoute(param.toJson());

  @override
  Future<BaseListResponse<AreaBaseModel>> getAreaBaseData(
    AreaBaseInfoParamModel param,
  ) => _addressService.getAreaBaseData(param.toJson());

  @override
  Future<BaseListResponse<ProvinceModel>> getProvinceList() =>
      _addressService.getCitiesWithProvince({});

  @override
  Future<BaseSingleResponse<List<ProvinceLookupModel>>>
      getProvinceLookupList() => _lookupService.getProvinceLookupList();

  @override
  Future<BaseSingleResponse<List<DiscountableAreaModel>>>
      getDiscountableAreas() => _lookupService.getDiscountableAreas();

  @override
  Future<BaseSingleResponse<LocationDataModel>> getLocationData(
    LocationModel param,
  ) => _addressService.getLocationData(param.toLocationRequestJson());
}
