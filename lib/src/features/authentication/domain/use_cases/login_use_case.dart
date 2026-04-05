import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase extends BaseUseCase<ApiResult<UserEntity?>, LoginRequestEntity?> {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<ApiResult<UserEntity?>> call(arg) async {
    final result = await _authRepository.login(arg);
    return result;
  }
}
