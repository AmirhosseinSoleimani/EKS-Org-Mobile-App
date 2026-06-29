import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/repositories/cartable_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHomeServiceRequestListUseCase
    extends
        BaseUseCase<
          ApiResult<List<SubordinatedUserEntity>>,
          GetSubordinatedUsersParamEntity
        > {
  final CartableRepository _repository;

  GetHomeServiceRequestListUseCase(this._repository);

  @override
  Future<ApiResult<List<SubordinatedUserEntity>>> call(arg) async {
    return await _repository.getSubordinatedUsers(arg);
  }
}
