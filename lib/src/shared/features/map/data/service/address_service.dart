import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/area_base_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_data_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/province_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'address_service.g.dart';

@RestApi()
@lazySingleton
abstract class AddressService {
  @factoryMethod
  factory AddressService(Dio dio) = _AddressService;

  @POST('/api/MapOrg/Route')
  Future<BaseSingleResponse<RouteDataModel>> getRoute(
      @Body() Map<String, dynamic> query);

  @GET('/api/AreaBaseInfoOrg/GetAreaBaseInfo')
  Future<BaseSingleResponse<AreaBaseModel>> getAreaBaseData(
      @Queries() Map<String, dynamic> query);


  @POST('/api/CityOrg/GetCitiesWithProvince')
  Future<BaseListResponse<ProvinceModel>> getCitiesWithProvince(
      @Queries() Map<String, dynamic> query);

  @POST('/api/MapOrg/GetLocationData')
  Future<BaseSingleResponse<LocationDataModel>> getLocationData(
      @Body() Map<String, dynamic> query);
}
