import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/model/session_model.dart';

abstract class SessionStorage {
  Future<void> saveSessionId(SessionModel? model);
  Future<SessionModel?> fetchSessionId();
  Future<void> deleteSessionId();
}
