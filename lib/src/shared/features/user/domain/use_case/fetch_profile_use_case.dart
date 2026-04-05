import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/di/app_environment.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(env: [AppEnvironment.defaultEnv, AppEnvironment.mobile])
class FetchProfileUseCase extends BaseUseCaseNoArgs  {
  FetchProfileUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<ApiResult<UserEntity?>> call() async {
    return await repository.fetchProfile();
  }
}
