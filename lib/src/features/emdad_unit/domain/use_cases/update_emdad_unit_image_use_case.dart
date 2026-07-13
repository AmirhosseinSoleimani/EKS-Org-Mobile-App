import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/update_emdad_unit_image_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateEmdadUnitImageUseCase {
  const UpdateEmdadUnitImageUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<EmdadUnitEntity>> call(UpdateEmdadUnitImageParamEntity param) {
    return _repository.updateImage(param);
  }
}
