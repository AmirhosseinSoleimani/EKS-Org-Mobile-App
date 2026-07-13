import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEmdadUnitListUseCase {
  const GetEmdadUnitListUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<EmdadUnitPageEntity>> call(EmdadUnitFilterParamEntity param) {
    return _repository.getByFilter(param);
  }
}
