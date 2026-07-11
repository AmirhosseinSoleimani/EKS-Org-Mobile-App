import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/get_current_session.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_sync_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncCurrentSessionUseCase {
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final CurrentSessionManager _currentSessionManager;

  SyncCurrentSessionUseCase(
      this._getCurrentSessionUseCase,
      this._currentSessionManager,
      );

  Future<CurrentSessionSyncResult> call({
    bool clearOnFailure = true,
  }) async {
    final result = await _getCurrentSessionUseCase.call();

    CurrentSessionSyncResult syncResult =
    const CurrentSessionSyncResult.failure();

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data == null) {
          if (clearOnFailure) {
            _currentSessionManager.clear();
          }

          syncResult = const CurrentSessionSyncResult.empty();
          return;
        }

        _currentSessionManager.setCurrentSession(data);
        syncResult = CurrentSessionSyncResult.success(data);
      },
      failure: (error, failure) {
        if (clearOnFailure) {
          _currentSessionManager.clear();
        }

        syncResult = CurrentSessionSyncResult.failure(
          failure ?? 'دریافت اطلاعات کاربر با خطا مواجه شد.',
        );
      },
      connectionError: () {
        syncResult = const CurrentSessionSyncResult.connectionError();
      },
    );

    return syncResult;
  }
}