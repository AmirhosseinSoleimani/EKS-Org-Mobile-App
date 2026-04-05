import 'dart:convert';
import 'package:eks_sana_plus_org/src/di/app_environment.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/model/session_model.dart';
import 'session_storage.dart';


@LazySingleton(as: SessionStorage, env: [AppEnvironment.web])
class SessionStorageWebImpl implements SessionStorage {
  static const String _sessionKey = 'sessionId';

  SessionStorageWebImpl();

  @override
  Future<SessionModel?> fetchSessionId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_sessionKey);

      if (jsonStr == null || jsonStr.isEmpty) return null;

      return SessionModel.fromJson(jsonDecode(jsonStr));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> deleteSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  @override
  Future<void> saveSessionId(SessionModel? model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(model?.toJson() ?? {});
    await prefs.setString(_sessionKey, jsonStr);
  }
}
