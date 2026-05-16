import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/address_to_location_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/area_base_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_to_address_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'map_service.g.dart';

@RestApi(baseUrl: "https://api.parsimap.ir/geocode/")
@lazySingleton
abstract class MapService {
  @factoryMethod
  factory MapService(Dio dio) = _MapService;

  @GET("/reverse?key=${AppConstants.parsiMapApiToken}&location={id}&local_address=false&approx_address=false&subdivision=false&plate=false&request_id=false")
  Future<LocationToAddressResponseModel?> fetchLocationToAddress(@Path() String id);

  @GET("/forward?key=${AppConstants.parsiMapApiToken}&search_text={id}&district={district}&only_in_district=true&subdivision=false&plate=false&request_id=false&search_precision=simple")
  Future<AddressToLocationResponseModel?> fetchAddressToLocation(@Path() String id, @Path() String district);
}
