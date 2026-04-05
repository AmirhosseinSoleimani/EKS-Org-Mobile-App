import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/data_source/session_storage.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase extends BaseUseCaseNoArgs {
  LogoutUseCase(this._repository, this._sessionStorage);

  final UserRepository _repository;
  final SessionStorage _sessionStorage;

  @override
  Future<ApiResult> call() async {
    final result = await _repository.logout();
    await _sessionStorage.deleteSessionId();
    return result;
  }
}
