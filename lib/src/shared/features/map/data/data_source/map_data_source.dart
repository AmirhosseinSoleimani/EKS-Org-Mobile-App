import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
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

abstract class MapDataSource {
  Future<AddressToLocationResponseModel?> fetchAddressToLocation(
    MapRequestModel? model,
  );

  Future<LocationToAddressResponseModel?> fetchLocationToAddress(
    MapRequestModel? model,
  );

  Future<BaseSingleResponse<RouteDataModel>> getRoute(RouteParamModel param);

  Future<BaseListResponse<AreaBaseModel>> getAreaBaseData(
    AreaBaseInfoParamModel param,
  );

  Future<BaseListResponse<ProvinceModel>> getProvinceList();

  Future<BaseSingleResponse<List<ProvinceLookupModel>>>
      getProvinceLookupList();

  Future<BaseSingleResponse<List<DiscountableAreaModel>>>
      getDiscountableAreas();

  Future<BaseSingleResponse<LocationDataModel>> getLocationData(
    LocationModel param,
  );
}
