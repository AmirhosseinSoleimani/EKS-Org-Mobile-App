import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'request_service.g.dart';

@RestApi()
@lazySingleton
abstract class RequestService {
  @factoryMethod
  factory RequestService(Dio dio) = _RequestService;

  @POST('/api/AidServiceRequest/GetByFilterJson')
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList(@Body() Map<String, dynamic> body);

  @GET('api/AidServiceRequest/GetById')
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/GetByFilterJson')
  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList(@Body() Map<String, dynamic> body);

  @GET('/api/HomeServiceRequest/GetById')
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      @Queries() Map<String, dynamic> query);
}
