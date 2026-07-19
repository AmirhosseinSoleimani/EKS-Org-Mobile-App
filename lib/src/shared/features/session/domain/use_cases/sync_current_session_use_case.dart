import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/get_current_session.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_sync_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncCurrentSessionUseCase {
  static const Duration defaultMaxAge = Duration(minutes: 5);
  static const Duration defaultMinRequestInterval = Duration(seconds: 30);

  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final CurrentSessionManager _currentSessionManager;
  Future<CurrentSessionSyncResult>? _inFlightSync;
  DateTime? _lastRequestAt;

  SyncCurrentSessionUseCase(
      this._getCurrentSessionUseCase,
      this._currentSessionManager,
      );

  Future<CurrentSessionSyncResult> call({
    bool clearOnFailure = true,
    bool forceRefresh = false,
    Duration maxAge = const Duration(minutes: 5),
    Duration minRequestInterval = const Duration(seconds: 30),
  }) async {
    final cachedSession = _currentSessionManager.currentSession;
    if (!forceRefresh &&
        cachedSession != null &&
        !_currentSessionManager.isStale(maxAge)) {
      return CurrentSessionSyncResult.success(cachedSession);
    }

    final inFlightSync = _inFlightSync;
    if (inFlightSync != null) {
      return inFlightSync;
    }

    if (!forceRefresh && !_canRequest(minRequestInterval)) {
      if (cachedSession != null) {
        return CurrentSessionSyncResult.success(cachedSession);
      }

      return const CurrentSessionSyncResult.empty();
    }

    _lastRequestAt = DateTime.now();
    _inFlightSync = _sync(clearOnFailure: clearOnFailure);

    try {
      return await _inFlightSync!;
    } finally {
      _inFlightSync = null;
    }
  }

  Future<CurrentSessionSyncResult> _sync({
    required bool clearOnFailure,
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

  bool _canRequest(Duration minRequestInterval) {
    final lastRequestAt = _lastRequestAt;
    if (lastRequestAt == null) return true;

    return DateTime.now().difference(lastRequestAt) >= minRequestInterval;
  }
}
