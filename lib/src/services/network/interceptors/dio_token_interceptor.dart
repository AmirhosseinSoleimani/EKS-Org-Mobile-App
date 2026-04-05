import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/data_source/session_storage.dart';
import 'package:injectable/injectable.dart';

class DioTokenInterceptor extends Interceptor {

  @singleton
  SessionStorage get _sessionStorage => getIt<SessionStorage>();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final sessionModel = await _sessionStorage.fetchSessionId();
    final sessionId = sessionModel?.sessionId ?? '';

    if (options.uri.toString().contains(AppConstants.baseApiUrl) && (sessionId.isNotEmpty)) {
      options.headers.addAll(sessionModel?.toJson() ??{});
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }
}
