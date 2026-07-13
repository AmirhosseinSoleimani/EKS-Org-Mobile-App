import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEmdadUnitPersonsUseCase {
  const GetEmdadUnitPersonsUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<List<EmdadUnitPersonEntity>>> call(int emdadUnitId) {
    return _repository.getPersons(emdadUnitId);
  }
}
