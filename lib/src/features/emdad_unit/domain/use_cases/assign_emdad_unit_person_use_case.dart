import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/assign_emdad_unit_person_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssignEmdadUnitPersonUseCase {
  const AssignEmdadUnitPersonUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<void>> call(AssignEmdadUnitPersonParamEntity param) {
    return _repository.assignPerson(param);
  }
}
