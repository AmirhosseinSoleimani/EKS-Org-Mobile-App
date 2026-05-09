import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/services/data/models/Followup_Model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/cancel_request_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/chassis_request_history_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/distance_kilometer_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_followups_data_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_history_item_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/request_status_history_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/update_service_response_model.dart';
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
  Future<BaseSingleResponse<ReliefRequestListModel>> getReliefRequestList(
      @Body() Map<String, dynamic> body);

  @GET('/api/AidServiceRequestOrg/GetAidServiceRequestById')
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequestOrg/GetHomeServiceRequestList')
  Future<BaseSingleResponse<HomeServiceRequestListModel>>
      getHomeServiceRequestList(@Body() Map<String, dynamic> body);

  @GET('/api/HomeServiceRequestOrg/GetHomeServiceRequest')
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      @Queries() Map<String, dynamic> query);


  @POST('/api/LackOfCooperationOrg/getLackOfCooperationList')
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      @Body() Map<String, dynamic> query);

  @POST('/api/CartableOrg/GetServiceRequestMessageFlow')
  Future<BaseListResponse<CartableCycleItemModel>> getCartableCycleList(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluationOrg/GetEvaluationsByServiceRequestId')
  Future<BaseListResponse<EvaluationHistoryItemModel>> getAidServiceEvaluationHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/HomeServiceEvaluationOrg/GetEvaluationsByServiceRequestId')
  Future<BaseListResponse<EvaluationHistoryItemModel>> getHomeServiceServiceEvaluationHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/ServiceRequestHistoryOrg/GetByFilterJson')
  Future<BaseSingleResponse<RequestStatusHistoryListModel>> getRequestStatusHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/EmdadgarOrg/GetEmdadgarByServiceRequestId')
  Future<BaseSingleResponse<EmdadgarInfoModel>> getEmdadgarInfo(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUpOrg/GetByFilterJson')
  Future<BaseSingleResponse<FollowupModel>> getRequestFollowUp(
      @Body() Map<String, dynamic> query);

  @POST('/api/CustomerViewAllOrg/GetServiceRequests')
  Future<BaseListResponse<ChassisRequestHistoryModel>> getChassisRequestHistoryList(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUpOrg/ServiceRequestsFollowUpByUser')
  Future<BaseSingleResponse<ControlInfoModel>> getControlInfo(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceRequestOrg/EditServiceRequest')
  Future<BaseSingleResponse<UpdateServiceResponseModel>> updateServiceRequest(
      @Body() Map<String, dynamic> query);

  @POST('/api/CancelReasonOrg/GetByFilterJson')
  Future<BaseListResponse<CancelRequestReasonModel>> getCancelReasons(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluationOrg/GetDistance')
  Future<BaseSingleResponse<DistanceKilometerModel>> getAidDistanceKilometer(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceRequest/CancelRequestService')
  Future<BaseSingleResponse<DistanceKilometerModel>> cancelAidRequestService(
      @Body() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/CancelHomeServiceRequest')
  Future<BaseSingleResponse<DistanceKilometerModel>> cancelHomeServiceRequest(
      @Body() Map<String, dynamic> query);

  @POST('/api/HomeServiceEvaluationOrg/GetDistance')
  Future<BaseSingleResponse<
      DistanceKilometerModel>> getHomeServiceDistanceKilometer(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluation/GetEmdadgarFollowupsData')
  Future<BaseSingleResponse<
      EmdadgarFollowupsDataModel>> getAidEmdadgarFollowupsData(
      @Body() Map<String, dynamic> query);
}
