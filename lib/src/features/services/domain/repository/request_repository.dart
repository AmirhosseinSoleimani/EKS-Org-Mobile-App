import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/complete_urgent_request_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/distance_kilometer_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_followups_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/complete_urgent_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_emdadgar_followups_data_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_reference_car_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/update_service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/reference_car_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/update_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class RequestRepository {
  Future<ApiResult<ReliefRequestListEntity>> getReliefRequestList(
      RequestFilterParamEntity param);

  Future<ApiResult<ReliefRequestEntity?>> getReliefRequestById(int id);

  Future<ApiResult<HomeServiceRequestListEntity>> getHomeServiceRequestList(
      RequestFilterParamEntity param);

  Future<ApiResult<HomeServiceRequestEntity?>> getHomeServiceRequestById(int id);

  Future<ApiResult<NonCooperationListEntity?>> getNonCooperationList(
      RequestOperationParamEntity param);

  Future<ApiResult<List<CartableCycleItemEntity>>> getCartableCycleList(
      RequestOperationParamEntity param);

  Future<ApiResult<List<EvaluationHistoryItemEntity>>> getEvaluationHistory(
      ServiceRequestParamEntity param);

  Future<ApiResult<RequestStatusHistoryListEntity>> getRequestStatusHistory(
      RequestOperationParamEntity param);

  Future<ApiResult<EmdadgarInfoEntity?>> getEmdadgarInfo(
      ServiceRequestParamEntity param);

  Future<ApiResult<FollowupEntity>> getRequestFollowupHistory(RequestOperationParamEntity param);

  Future<ApiResult<List<ChassisRequestHistoryEntity>>>
      getChassisRequestHistoryList(ChassisParamEntity param);

  Future<ApiResult<ControlInfoEntity>>
  getControlInfo(ServiceRequestParamEntity param);

  Future<ApiResult<UpdateServiceResponseEntity>> updateServiceRequest(UpdateServiceRequestParamEntity param);

  Future<ApiResult<List<CancelRequestReasonEntity>>> getCancelReasons(
      CancelReasonParamEntity param);

  Future<ApiResult<void>> cancelServiceRequest(
      CancelRequestParamEntity param);

  Future<ApiResult<DistanceKilometerEntity>> getDistanceKilometer(
      DistanceKilometerParamEntity param);

  Future<ApiResult<EmdadgarFollowupsDataEntity>> getEmdadgarFollowupsData(
      GetEmdadgarFollowupsDataParamEntity param);

  Future<ApiResult<CarCoversDataEntity>> getBasicData();

  Future<ApiResult<ReferenceCarEntity>> getReferenceCar(
      GetReferenceCarParamEntity param);

  Future<ApiResult<CompleteUrgentRequestDataEntity>> completeAidUrgentRequest(
      CompleteUrgentParamEntity param);
}
