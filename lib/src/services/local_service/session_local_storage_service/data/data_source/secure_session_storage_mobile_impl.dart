import 'dart:convert';
import 'package:eks_sana_plus_org/src/di/app_environment.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/data_source/session_storage.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/model/session_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SessionStorage, env: [AppEnvironment.mobile])
class SessionStorageMobileImpl extends SessionStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _sessionKey = 'sessionId';

  SessionStorageMobileImpl();

  @override
  Future<SessionModel?> fetchSessionId() async {
    final jsonStr= await _secureStorage.read(key: _sessionKey);
    if (jsonStr == null || jsonStr.isEmpty) return null;
    return SessionModel.fromJson(jsonDecode(jsonStr));
  }

  @override
  Future<void> deleteSessionId() async {
    await _secureStorage.delete(key: _sessionKey);
  }

  @override
  Future<void> saveSessionId(SessionModel? model) async{
    final jsonStr = jsonEncode(model?.toJson() ?? {});
    await _secureStorage.write(key: _sessionKey, value: jsonStr);
  }
}

