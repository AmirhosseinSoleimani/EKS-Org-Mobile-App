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
import 'package:eks_sana_plus_org/src/features/services/data/models/follow_up_status_type_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/message_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/minimal_customer_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_reason_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/change_time_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/chassis_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/complete_urgent_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/create_follow_up_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/distance_kilometer_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_emdadgar_followups_data_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_reference_car_param_data.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_times_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/minimal_customer_info_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_operation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/update_service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/post_follow_up_response_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/reference_car_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/request_status_history_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/update_service_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

import '../models/evaluation_history_item_model.dart';


abstract class RequestDataSource {
  Future<BaseSingleResponse<ReliefRequestListModel>> getReliefRequestList(RequestFilterParamModel param);

  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(int id);

  Future<BaseSingleResponse<HomeServiceRequestListModel>> getHomeServiceRequestList(RequestFilterParamModel param);

  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(int id);

  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      RequestOperationParamModel param);

  Future<BaseListResponse<CartableCycleItemModel>> getCartableCycleList(
      RequestOperationParamModel param);

  Future<BaseListResponse<EvaluationHistoryItemModel>> getEvaluationHistory(
      ServiceRequestParamModel param);

  Future<BaseSingleResponse<RequestStatusHistoryListModel>>
      getRequestStatusHistory(RequestOperationParamModel param);

  Future<BaseSingleResponse<EmdadgarInfoModel>> getEmdadgarInfo(ServiceRequestParamModel param);

  Future<BaseSingleResponse<FollowupModel>> getRequestFollowUp(RequestOperationParamModel param);

  Future<BaseListResponse<ChassisRequestHistoryModel>>
      getChassisRequestHistoryList(ChassisParamModel param);

  Future<BaseSingleResponse<ControlInfoModel>>
      getControlInfo(ServiceRequestParamModel param);

  Future<BaseSingleResponse<UpdateServiceResponseModel>>
  updateServiceRequest(UpdateServiceRequestParamModel param);

  Future<BaseListResponse<CancelRequestReasonModel>>
  getCancelReasons(CancelReasonParamModel param);

  Future<BaseSingleResponse<DistanceKilometerModel>> getDistanceKilometer(
      DistanceKilometerParamModel param);

  Future<BaseSingleResponse<void>> cancelServiceRequest(
      CancelRequestParamModel param);

  Future<
      BaseSingleResponse<EmdadgarFollowupsDataModel>> getEmdadgarFollowupsData(
      GetEmdadgarFollowupsDataParamModel param);


  Future<BaseSingleResponse<CarCoversDataModel?>> getBasicData();

  Future<BaseSingleResponse<ReferenceCarModel?>> getReferenceCar(
      GetReferenceCarParamModel param);

  Future<BaseSingleResponse<CompleteUrgentRequestDataModel>> completeAidUrgentRequest(
      CompleteUrgentParamModel param);

  Future<BaseSingleResponse<MinimalCustomerInfoModel?>> getMinimalCustomerInfo(
      MinimalCustomerInfoParamModel param);


  Future<BaseListResponse<FollowUpStatusTypeModel>> getFollowUpStatusTypes();

  Future<BaseSingleResponse<
      PostFollowUpResponseModel>> createFollowUp(CreateFollowUpParamModel param);

  Future<BaseListResponse<DayScheduleModel>> getTimes(
      GetTimesParamModel model);

  Future<BaseSingleResponse<MessageModel>> changeTime(
      ChangeTimeParamModel model);
}
