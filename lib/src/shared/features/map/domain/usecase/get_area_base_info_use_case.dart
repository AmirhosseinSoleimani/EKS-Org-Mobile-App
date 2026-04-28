import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/area_base_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAreaBaseInfoUseCase extends BaseUseCaseNoArgs {
  GetAreaBaseInfoUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<AreaBaseEntity>> call() async {
    return _repository.getAreaBaseData();
  }
}
