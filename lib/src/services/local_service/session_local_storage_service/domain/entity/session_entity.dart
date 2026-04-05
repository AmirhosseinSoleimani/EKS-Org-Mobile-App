import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/model/session_model.dart';

class SessionEntity {
  const SessionEntity({
    this.sessionId,
  });

  final String? sessionId;

  SessionEntity copyWith({
    String? sessionId,
  }) {
    return SessionEntity(
      sessionId: sessionId ?? this.sessionId,
    );
  }

  SessionModel toModel() {
    return SessionModel(
      sessionId: sessionId,
    );
  }
}