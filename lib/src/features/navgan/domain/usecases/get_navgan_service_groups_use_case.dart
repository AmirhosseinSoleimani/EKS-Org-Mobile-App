import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNavganServiceGroupsUseCase extends BaseUseCase<
    ApiResult<List<NavganServiceGroupEntity>>, NavganIdParamEntity> {
  GetNavganServiceGroupsUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<List<NavganServiceGroupEntity>>> call(
    NavganIdParamEntity arg,
  ) {
    return _repository.getServiceGroups(arg);
  }
}
