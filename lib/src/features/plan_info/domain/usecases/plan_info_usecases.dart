import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/cancel_plan_requests_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_info_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/create_plan_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_cancelation_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/repository/plan_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPlanListUseCase
    extends BaseUseCase<ApiResult<PlanInfoListEntity>, PlanFilterParamEntity> {
  final PlanInfoRepository _repository;

  GetPlanListUseCase(this._repository);

  @override
  Future<ApiResult<PlanInfoListEntity>> call(PlanFilterParamEntity arg) {
    return _repository.getPlans(arg);
  }
}

@lazySingleton
class GetPlanByIdUseCase
    extends BaseUseCase<ApiResult<PlanInfoEntity?>, int> {
  final PlanInfoRepository _repository;

  GetPlanByIdUseCase(this._repository);

  @override
  Future<ApiResult<PlanInfoEntity?>> call(int arg) {
    return _repository.getPlanById(arg);
  }
}

@lazySingleton
class CreatePlanUseCase extends BaseUseCase<ApiResult<void>, CreatePlanInfoParamEntity> {
  final PlanInfoRepository _repository;

  CreatePlanUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(CreatePlanInfoParamEntity arg) {
    return _repository.createPlan(arg);
  }
}

@lazySingleton
class EditPlanUseCase extends BaseUseCase<ApiResult<void>, CreatePlanInfoParamEntity> {
  final PlanInfoRepository _repository;

  EditPlanUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(CreatePlanInfoParamEntity arg) {
    return _repository.editPlan(arg);
  }
}

@lazySingleton
class DeletePlanUseCase extends BaseUseCase<ApiResult<void>, int> {
  final PlanInfoRepository _repository;

  DeletePlanUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(int arg) {
    return _repository.deletePlan(arg);
  }
}

@lazySingleton
class GetPlanStatusReasonsUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<PlanLookupEntity>>> {
  final PlanInfoRepository _repository;

  GetPlanStatusReasonsUseCase(this._repository);

  @override
  Future<ApiResult<List<PlanLookupEntity>>> call() {
    return _repository.getStatusReasons();
  }
}

@lazySingleton
class ChangePlanStatusUseCase
    extends BaseUseCase<ApiResult<void>, ChangePlanStatusParamEntity> {
  final PlanInfoRepository _repository;

  ChangePlanStatusUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(ChangePlanStatusParamEntity arg) {
    return _repository.changeStatus(arg);
  }
}

@lazySingleton
class GetPlanReportUseCase
    extends BaseUseCase<ApiResult<List<PlanInfoEntity>>, PlanFilterParamEntity> {
  final PlanInfoRepository _repository;

  GetPlanReportUseCase(this._repository);

  @override
  Future<ApiResult<List<PlanInfoEntity>>> call(PlanFilterParamEntity arg) {
    return _repository.getPlanReport(arg);
  }
}

@lazySingleton
class CancelPlanRequestsUseCase extends BaseUseCase<ApiResult<PlanCancelationEntity>,
    CancelPlanRequestsParamEntity> {
  final PlanInfoRepository _repository;

  CancelPlanRequestsUseCase(this._repository);

  @override
  Future<ApiResult<PlanCancelationEntity>> call(CancelPlanRequestsParamEntity arg) {
    return _repository.cancelAllAssignedRequest(arg);
  }
}

@lazySingleton
class GetPlanLookupsUseCase
    extends BaseUseCaseNoArgs<ApiResult<PlanLookupsEntity>> {
  final PlanInfoRepository _repository;

  GetPlanLookupsUseCase(this._repository);

  @override
  Future<ApiResult<PlanLookupsEntity>> call() async {
    final units = await _repository.getEmdadUnits();
    final shifts = await _repository.getShifts();
    final specialPlans = await _repository.getSpecialPlans();
    final locations = await _repository.getLocations();

    final failures = <String>[];
    var hasConnectionError = false;

    List<PlanLookupEntity> read(ApiResult<List<PlanLookupEntity>> result) {
      return result.when(
        success: (data, _, __) => data,
        failure: (_, message) {
          if (message != null) failures.add(message);
          return const <PlanLookupEntity>[];
        },
        expireToken: () => const <PlanLookupEntity>[],
        connectionError: () {
          hasConnectionError = true;
          return const <PlanLookupEntity>[];
        },
      );
    }

    final data = PlanLookupsEntity(
      emdadUnits: read(units),
      shifts: read(shifts),
      specialPlans: read(specialPlans),
      locations: read(locations),
    );

    if (hasConnectionError) return const ApiResult.connectionError();
    if (failures.isNotEmpty) {
      return ApiResult.failure(failures: failures.join('\n'));
    }

    return ApiResult.success(data: data);
  }
}


@lazySingleton
class ChangeLocationUseCase
    extends BaseUseCase<ApiResult<void>, ChangePlanInfoLocationParamEntity> {
  final PlanInfoRepository _repository;

  ChangeLocationUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(ChangePlanInfoLocationParamEntity arg) {
    return _repository.changeLocation(arg);
  }
}

class PlanLookupsEntity {
  final List<PlanLookupEntity> emdadUnits;
  final List<PlanLookupEntity> shifts;
  final List<PlanLookupEntity> specialPlans;
  final List<PlanLookupEntity> locations;

  const PlanLookupsEntity({
    required this.emdadUnits,
    required this.shifts,
    required this.specialPlans,
    required this.locations,
  });
}
