import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/repository/special_plan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateSpecialPlanUseCase
    extends BaseUseCase<ApiResult<String>, SpecialPlanFormParamEntity> {
  UpdateSpecialPlanUseCase(this._repository);

  final SpecialPlanRepository _repository;

  @override
  Future<ApiResult<String>> call(SpecialPlanFormParamEntity arg) =>
      _repository.update(arg);
}
