import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/services/data/models/Followup_Model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/cancel_request_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/car_covers_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/chassis_request_history_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/complete_urgent_request_data_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/day_schedule_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/distance_kilometer_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_followups_data_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_history_item_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/follow_up_status_type_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/message_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/minimal_customer_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/post_follow_up_response_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/reference_car_model.dart';
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

  @POST('/api/AidServiceRequest/GetAidServiceRequestList')
  Future<BaseSingleResponse<ReliefRequestListModel>> getReliefRequestList(
      @Body() Map<String, dynamic> body);

  @GET('/api/AidServiceRequest/GetAidServiceRequestById')
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/GetHomeServiceRequestList')
  Future<BaseSingleResponse<HomeServiceRequestListModel>>
      getHomeServiceRequestList(@Body() Map<String, dynamic> body);

  @GET('/api/HomeServiceRequest/GetHomeServiceRequest')
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      @Queries() Map<String, dynamic> query);


  @POST('/api/LackOfCooperation/getLackOfCooperationList')
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      @Body() Map<String, dynamic> query);

  @POST('/api/Cartable/GetServiceRequestMessageFlow')
  Future<BaseListResponse<CartableCycleItemModel>> getCartableCycleList(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluation/GetEvaluationsByServiceRequestId')
  Future<BaseListResponse<EvaluationHistoryItemModel>> getAidServiceEvaluationHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/HomeServiceEvaluation/GetEvaluationsByServiceRequestId')
  Future<BaseListResponse<EvaluationHistoryItemModel>> getHomeServiceServiceEvaluationHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/ServiceRequestHistory/GetByFilterJson')
  Future<BaseSingleResponse<RequestStatusHistoryListModel>> getRequestStatusHistory(
      @Body() Map<String, dynamic> query);

  @POST('/api/Emdadgar/GetEmdadgarByServiceRequestId')
  Future<BaseSingleResponse<EmdadgarInfoModel>> getEmdadgarInfo(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUp/GetByFilterJson')
  Future<BaseSingleResponse<FollowupModel>> getRequestFollowUp(
      @Body() Map<String, dynamic> query);

  @POST('/api/CustomerViewAll/GetServiceRequests')
  Future<BaseListResponse<ChassisRequestHistoryModel>> getChassisRequestHistoryList(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUp/ServiceRequestsFollowUpByUser')
  Future<BaseSingleResponse<ControlInfoModel>> getControlInfo(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceRequest/EditServiceRequest')
  Future<BaseSingleResponse<UpdateServiceResponseModel>> updateServiceRequest(
      @Body() Map<String, dynamic> query);

  @POST('/api/CancelReason/getCancelReasonList')
  Future<BaseListResponse<CancelRequestReasonModel>> getCancelReasons(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluation/GetDistance')
  Future<BaseSingleResponse<DistanceKilometerModel>> getAidDistanceKilometer(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceRequest/CancelRequestService')
  Future<BaseSingleResponse<DistanceKilometerModel>> cancelAidRequestService(
      @Body() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/CancelHomeServiceRequest')
  Future<BaseSingleResponse<DistanceKilometerModel>> cancelHomeServiceRequest(
      @Body() Map<String, dynamic> query);

  @POST('/api/HomeServiceEvaluation/GetDistance')
  Future<BaseSingleResponse<
      DistanceKilometerModel>> getHomeServiceDistanceKilometer(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceEvaluation/GetEmdadgarFollowupsData')
  Future<BaseSingleResponse<
      EmdadgarFollowupsDataModel>> getAidEmdadgarFollowupsData(
      @Body() Map<String, dynamic> query);

  @POST('/api/AidServiceRequest/CompleteUrgentRequest')
  Future<BaseSingleResponse<
      CompleteUrgentRequestDataModel>> completeAidUrgentRequest(
      @Body() Map<String, dynamic> query);

  @POST('/api/CarInfo/GetReferenceCar')
  Future<BaseSingleResponse<
      ReferenceCarModel?>> getReferenceCar(
      @Body() Map<String, dynamic> query);

  @GET('/api/BaseInfo/GetBasicData')
  Future<BaseSingleResponse<
      CarCoversDataModel?>> getBasicData(
      @Queries() Map<String, dynamic> query);

  @POST('/api/CustomerViewAll/GetMinimalCustomerInfo')
  Future<BaseSingleResponse<
      MinimalCustomerInfoModel?>> getMinimalCustomerInfo(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUp/GetFollowUpResultStatusTypes')
  Future<BaseListResponse<
      FollowUpStatusTypeModel>> getFollowUpStatusTypes(
      @Body() Map<String, dynamic> query);

  @POST('/api/RequestFollowUp/Post')
  Future<BaseSingleResponse<PostFollowUpResponseModel>> createFollowUp(
      @Body() Map<String, dynamic> query);

  @GET('api/HomeServiceRequest/GetTimeForHomeServiceRequestByServiceRequestID')
  Future<BaseListResponse<DayScheduleModel>> getTimes(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/ChangeHomeServiceRequestTime')
  Future<BaseSingleResponse<MessageModel>> changeTime(
      @Body() Map<String, dynamic> body);



}
