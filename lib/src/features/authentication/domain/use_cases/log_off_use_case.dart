import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/profile_repository.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/data_source/session_storage.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogOffUseCase extends BaseUseCaseNoArgs<ApiResult<String>> {
  LogOffUseCase(
    this._repository,
    this._sessionStorage,
    this._currentSessionManager,
  );

  final ProfileRepository _repository;
  final SessionStorage _sessionStorage;
  final CurrentSessionManager _currentSessionManager;

  @override
  Future<ApiResult<String>> call() async {
    final result = await _repository.logOff();

    // Local authentication state must be cleared even when the remote logoff
    // request cannot complete. This keeps the application session consistent.
    await _sessionStorage.deleteSessionId();
    _currentSessionManager.clear();

    return result;
  }
}
