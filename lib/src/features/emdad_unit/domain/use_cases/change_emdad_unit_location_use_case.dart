import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeEmdadUnitLocationUseCase {
  const ChangeEmdadUnitLocationUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<void>> call(ChangeEmdadUnitLocationParamEntity param) {
    return _repository.changeLocation(param);
  }
}
