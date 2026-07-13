import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteEmdadUnitUseCase {
  const DeleteEmdadUnitUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<void>> call(int id) {
    return _repository.deleteById(id);
  }
}
