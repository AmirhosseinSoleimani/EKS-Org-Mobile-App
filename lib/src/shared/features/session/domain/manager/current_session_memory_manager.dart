import 'dart:async';

import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/policies/current_session_access_policy.dart';

import 'package:injectable/injectable.dart';


@LazySingleton(as: CurrentSessionManager)
class CurrentSessionMemoryManager implements CurrentSessionManager {
  CurrentSessionEntity? _currentSession;
  DateTime? _lastSyncedAt;

  final StreamController<CurrentSessionEntity?> _controller =
  StreamController<CurrentSessionEntity?>.broadcast();

  @override
  CurrentSessionEntity? get currentSession => _currentSession;

  @override
  CurrentSessionAccessPolicy? get access {
    final session = _currentSession;
    if (session == null) return null;

    return CurrentSessionAccessPolicy(session);
  }

  @override
  Stream<CurrentSessionEntity?> get currentSessionStream {
    return _controller.stream;
  }

  @override
  bool get hasSession => _currentSession != null;

  @override
  DateTime? get lastSyncedAt => _lastSyncedAt;

  @override
  bool isStale(Duration maxAge) {
    final syncedAt = _lastSyncedAt;
    if (syncedAt == null) return true;

    return DateTime.now().difference(syncedAt) > maxAge;
  }


  @override
  void setCurrentSession(CurrentSessionEntity session) {
    _currentSession = session;
    _lastSyncedAt = DateTime.now();
    _controller.add(_currentSession);
  }

  @override
  void clear() {
    _currentSession = null;
    _controller.add(null);
  }

  @override
  @disposeMethod
  void dispose() {
    _controller.close();
  }
}
