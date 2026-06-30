import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/policies/current_session_access_policy.dart';

abstract class CurrentSessionManager {
  CurrentSessionEntity? get currentSession;

  CurrentSessionAccessPolicy? get access;

  Stream<CurrentSessionEntity?> get currentSessionStream;

  bool get hasSession;

  void setCurrentSession(CurrentSessionEntity session);

  void clear();

  void dispose();
}
