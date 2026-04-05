import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfileUseCase extends BaseUseCase<ApiResult<UserEntity?>, UserEntity?> {
  UpdateProfileUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<ApiResult<UserEntity?>> call(arg) async {
    final result = await _repository.updateProfile(arg);
    return result;
  }
}
