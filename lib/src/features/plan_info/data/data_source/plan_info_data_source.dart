import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/cancel_plan_requests_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/change_plan_info_location_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/change_plan_status_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/create_plan_info_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/plan_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_cancelation_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_history_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_info_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_lookup_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class PlanInfoDataSource {
  Future<BaseSingleResponse<PlanInfoListModel>> getPlans(
    PlanFilterParamModel param,
  );

  Future<BaseSingleResponse<PlanInfoModel>> getPlanById(int id);

  Future<BaseSingleResponse<String>> createPlan(CreatePlanInfoParamModel param);

  Future<BaseSingleResponse<String>> editPlan(CreatePlanInfoParamModel param);

  Future<BaseSingleResponse<void>> deletePlan(int id);

  Future<BaseListResponse<PlanLookupModel>> getStatusReasons();

  Future<BaseSingleResponse<void>> changeStatus(
    ChangePlanStatusParamModel param,
  );

  Future<BaseListResponse<PlanInfoModel>> getPlanReport(
    PlanFilterParamModel param,
  );

  Future<BaseSingleResponse<PlanCancelationModel>> cancelAllAssignedRequest(
    CancelPlanRequestsParamModel param,
  );

  Future<BaseSingleResponse<PlanLookupListModel>> getEmdadUnits();

  Future<BaseSingleResponse<PlanLookupListModel>> getShifts();

  Future<BaseSingleResponse<PlanLookupListModel>> getSpecialPlans();

  Future<BaseSingleResponse<PlanLookupListModel>> getLocations();

  Future<BaseSingleResponse<void>> changeLocation(ChangePlanInfoLocationParamModel param);

  Future<BaseListResponse<PlanHistoryModel>> getPlanHistories(
    Map<String, dynamic> queryParameters,
  );
}
