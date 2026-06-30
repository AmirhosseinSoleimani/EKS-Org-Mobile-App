import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrentSessionUseCase
    extends BaseUseCaseNoArgs<ApiResult<CurrentSessionEntity?>> {
  GetCurrentSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<ApiResult<CurrentSessionEntity?>> call() async {
    return await _authRepository.getCurrentSession();
  }
}
