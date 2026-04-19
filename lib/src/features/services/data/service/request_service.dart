import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
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

  @POST('/api/AidServiceRequest/GetAidServiceRequestList')
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList(@Body() Map<String, dynamic> body);

  @GET('api/AidServiceRequest/GetById')
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/GetHomeServiceRequestList')
  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceRequest/GetById')
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/LackOfCooperation/getLackOfCooperationList')
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      @Queries() Map<String, dynamic> query);
}
