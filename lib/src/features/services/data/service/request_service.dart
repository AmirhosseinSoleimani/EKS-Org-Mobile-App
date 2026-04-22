import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_history_item_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/request_status_history_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'request_service.g.dart';

@RestApi()
@lazySingleton
abstract class RequestService {
  @factoryMethod
  factory RequestService(Dio dio) = _RequestService;

  @POST('/api/AidServiceRequestOrg/GetAidServiceRequestList')
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList(@Body() Map<String, dynamic> body);

  @GET('/api/AidServiceRequestOrg/GetAidServiceRequestById')
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequestOrg/GetHomeServiceRequestList')
  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceRequestOrg/GetServiceRequest')
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/LackOfCooperationOrg/getLackOfCooperationList')
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      @Body() Map<String, dynamic> query);

  @POST('/api/CartableOrg/GetServiceRequestMessageFlow')
  Future<BaseListResponse<CartableCycleItemModel>> getCartableCycleList(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluationOrg/GetEvaluationsByServiceRequestId')
  Future<BaseListResponse<EvaluationHistoryItemModel>> getEvaluationHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/ServiceRequestHistoryOrg/GetByFilterJson')
  Future<BaseSingleResponse<RequestStatusHistoryListModel>> getRequestStatusHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/EmdadgarOrg/GetEmdadgarByServiceRequestId')
  Future<BaseSingleResponse<EmdadgarInfoModel>> getEmdadgarInfo(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUpOrg/GetByFilterJson')
  Future<BaseSingleResponse<EmdadgarInfoModel>> getRequestFollowUp(
      @Body() Map<String, dynamic> query);
}
