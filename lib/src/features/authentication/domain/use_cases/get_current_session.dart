import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase
    extends BaseUseCaseNoArgs<ApiResult<getCurrentSessionUseCase>> {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<ApiResult<LoginResponseEntity?>> call(arg) async {
    return await _authRepository.login(arg);
  }
}
