import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/create_emdad_unit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateEmdadUnitUseCase {
  const CreateEmdadUnitUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<EmdadUnitEntity>> call(CreateEmdadUnitParamEntity param) {
    return _repository.create(param);
  }
}
