import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class RequestRepository {
  Future<ApiResult<List<ReliefRequestEntity>>> getReliefRequestList(
      RequestFilterParamEntity param);

  Future<ApiResult<ReliefRequestEntity?>> getReliefRequestById(int id);

  Future<ApiResult<List<HomeServiceRequestEntity>>> getHomeServiceRequestList(
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
}
