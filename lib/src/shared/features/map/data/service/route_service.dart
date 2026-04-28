import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/area_base_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'route_service.g.dart';

@RestApi()
@lazySingleton
abstract class RouteService {
  @factoryMethod
  factory RouteService(Dio dio) = _RouteService;

  @POST('/api/MapOrg/Route')
  Future<BaseSingleResponse<RouteDataModel>> getRoute(
      @Body() Map<String, dynamic> query);

  @GET('/api/AreaBaseInfoOrg/GetAreaBaseInfo')
  Future<BaseSingleResponse<AreaBaseModel>> getAreaBaseData(
      @Queries() Map<String, dynamic> query);
}
