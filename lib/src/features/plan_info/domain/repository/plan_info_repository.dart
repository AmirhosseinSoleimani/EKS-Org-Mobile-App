import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/cancel_plan_requests_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_info_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/create_plan_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_cancelation_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class PlanInfoRepository {
  Future<ApiResult<PlanInfoListEntity>> getPlans(PlanFilterParamEntity param);

  Future<ApiResult<PlanInfoEntity?>> getPlanById(int id);

  Future<ApiResult<void>> createPlan(CreatePlanInfoParamEntity param);

  Future<ApiResult<void>> editPlan(CreatePlanInfoParamEntity param);

  Future<ApiResult<void>> deletePlan(int id);

  Future<ApiResult<List<PlanLookupEntity>>> getStatusReasons();

  Future<ApiResult<void>> changeStatus(ChangePlanStatusParamEntity param);

  Future<ApiResult<List<PlanInfoEntity>>> getPlanReport(
    PlanFilterParamEntity param,
  );

  Future<ApiResult<PlanCancelationEntity>> cancelAllAssignedRequest(
    CancelPlanRequestsParamEntity param,
  );

  Future<ApiResult<List<PlanLookupEntity>>> getEmdadUnits();

  Future<ApiResult<List<PlanLookupEntity>>> getShifts();

  Future<ApiResult<List<PlanLookupEntity>>> getSpecialPlans();

  Future<ApiResult<List<PlanLookupEntity>>> getLocations();
  Future<ApiResult<void>> changeLocation(ChangePlanInfoLocationParamEntity arg);

}
