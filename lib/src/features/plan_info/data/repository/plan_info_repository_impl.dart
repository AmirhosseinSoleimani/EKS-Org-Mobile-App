import 'package:eks_sana_plus_org/src/features/plan_info/data/data_source/plan_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/cancel_plan_requests_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/create_plan_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_cancelation_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/repository/plan_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PlanInfoRepository)
class PlanInfoRepositoryImpl extends PlanInfoRepository {
  final PlanInfoDataSource _dataSource;

  PlanInfoRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<PlanInfoListEntity>> getPlans(
    PlanFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getPlans(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PlanInfoEntity?>> getPlanById(int id) async {
    try {
      final result = await _dataSource.getPlanById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> createPlan(CreatePlanInfoParamEntity param) async {
    try {
      final result = await _dataSource.createPlan(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> editPlan(CreatePlanInfoParamEntity param) async {
    try {
      final result = await _dataSource.editPlan(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deletePlan(int id) async {
    try {
      final result = await _dataSource.deletePlan(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PlanLookupEntity>>> getStatusReasons() async {
    try {
      final result = await _dataSource.getStatusReasons();
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> changeStatus(ChangePlanStatusParamEntity param) async {
    try {
      final result = await _dataSource.changeStatus(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PlanInfoEntity>>> getPlanReport(
    PlanFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getPlanReport(param.toModel());
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PlanCancelationEntity>> cancelAllAssignedRequest(
    CancelPlanRequestsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.cancelAllAssignedRequest(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PlanLookupEntity>>> getEmdadUnits() async {
    try {
      final result = await _dataSource.getEmdadUnits();
      return result.toApiResult().when(
            success: (data, failures, resultCode) => ApiResult.success(
              data: data.records.cast<PlanLookupEntity>(),
              failures: failures,
              resultCode: resultCode,
            ),
            failure: (error, failures) => ApiResult.failure(
              error: error,
              failures: failures,
            ),
            expireToken: () => const ApiResult.expireToken(),
            connectionError: () => const ApiResult.connectionError(),
          );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PlanLookupEntity>>> getShifts() async {
    try {
      final result = await _dataSource.getShifts();
      return result.toApiResult().when(
            success: (data, failures, resultCode) => ApiResult.success(
              data: data.records.cast<PlanLookupEntity>(),
              failures: failures,
              resultCode: resultCode,
            ),
            failure: (error, failures) => ApiResult.failure(
              error: error,
              failures: failures,
            ),
            expireToken: () => const ApiResult.expireToken(),
            connectionError: () => const ApiResult.connectionError(),
          );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PlanLookupEntity>>> getSpecialPlans() async {
    try {
      final result = await _dataSource.getSpecialPlans();
      return result.toApiResult().when(
            success: (data, failures, resultCode) => ApiResult.success(
              data: data.records.cast<PlanLookupEntity>(),
              failures: failures,
              resultCode: resultCode,
            ),
            failure: (error, failures) => ApiResult.failure(
              error: error,
              failures: failures,
            ),
            expireToken: () => const ApiResult.expireToken(),
            connectionError: () => const ApiResult.connectionError(),
          );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PlanLookupEntity>>> getLocations() async {
    try {
      final result = await _dataSource.getLocations();
      return result.toApiResult().when(
            success: (data, failures, resultCode) => ApiResult.success(
              data: data.records.cast<PlanLookupEntity>(),
              failures: failures,
              resultCode: resultCode,
            ),
            failure: (error, failures) => ApiResult.failure(
              error: error,
              failures: failures,
            ),
            expireToken: () => const ApiResult.expireToken(),
            connectionError: () => const ApiResult.connectionError(),
          );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
