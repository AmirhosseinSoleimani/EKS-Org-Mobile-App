import 'package:eks_sana_plus_org/src/features/plan_info/data/data_source/plan_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/cancel_plan_requests_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/change_plan_info_location_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/change_plan_status_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/create_plan_info_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/plan_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_cancelation_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_history_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_info_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_lookup_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/service/plan_info_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PlanInfoDataSource)
class PlanInfoDataSourceImpl extends PlanInfoDataSource {
  final PlanInfoService _service;

  PlanInfoDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<PlanInfoListModel>> getPlans(
    PlanFilterParamModel param,
  ) =>
      _service.getPlans(param.toJson());

  @override
  Future<BaseSingleResponse<PlanInfoModel>> getPlanById(int id) =>
      _service.getPlanById({'Id': id});

  @override
  Future<BaseSingleResponse<void>> createPlan(
    CreatePlanInfoParamModel param,
  ) =>
      _service.createPlan(param.toJson());

  @override
  Future<BaseSingleResponse<void>> editPlan(CreatePlanInfoParamModel param) =>
      _service.editPlan(param.toJson());

  @override
  Future<BaseSingleResponse<void>> deletePlan(int id) =>
      _service.deletePlan({'id': id});

  @override
  Future<BaseListResponse<PlanLookupModel>> getStatusReasons() =>
      _service.getStatusReasons(const {});

  @override
  Future<BaseSingleResponse<void>> changeStatus(
    ChangePlanStatusParamModel param,
  ) =>
      _service.changeStatus(param.toJson());

  @override
  Future<BaseListResponse<PlanInfoModel>> getPlanReport(
    PlanFilterParamModel param,
  ) {
    final body = param.toJson()
      ..['PageSize'] = 0
      ..['Skip'] = 0;
    return _service.getPlanReport(body);
  }

  @override
  Future<BaseSingleResponse<PlanCancelationModel>> cancelAllAssignedRequest(
    CancelPlanRequestsParamModel param,
  ) =>
      _service.cancelAllAssignedRequest(param.toJson());

  @override
  Future<BaseSingleResponse<PlanLookupListModel>> getEmdadUnits() {
    return _service.getEmdadUnits({
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {'Field': 'type', 'Operator': 'eq', 'Value': '1'},
        ],
      },
      'PageSize': 0,
      'Skip': 0,
    });
  }

  @override
  Future<BaseSingleResponse<PlanLookupListModel>> getShifts() {
    return _service.getShifts({
      'Filter': {'Logic': 'and', 'Filters': []},
      'PageSize': 0,
      'Skip': 0,
    });
  }

  @override
  Future<BaseSingleResponse<PlanLookupListModel>> getSpecialPlans() {
    return _service.getSpecialPlans({
      'Filter': {'Logic': 'and', 'Filters': []},
      'PageSize': 0,
      'Skip': 0,
    });
  }

  @override
  Future<BaseSingleResponse<PlanLookupListModel>> getLocations() {
    return _service.getLocations({
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {'Field': 'isActive', 'Operator': 'eq', 'Value': 'true'},
        ],
      },
      'PageSize': 0,
      'Skip': 0,
    });
  }

  @override
  Future<BaseSingleResponse<void>> changeLocation(ChangePlanInfoLocationParamModel param) {
    return _service.changeLocation(param.toJson());
  }

  @override
  Future<BaseListResponse<PlanHistoryModel>> getPlanHistories(
    Map<String, dynamic> queryParameters,
  ) {
    return _service.getPlanHistories(queryParameters);
  }
}
