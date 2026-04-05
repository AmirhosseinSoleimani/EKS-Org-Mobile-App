import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/services/network/interceptors/dio_token_interceptor.dart';
import 'package:eks_sana_plus_org/src/services/network/interceptors/pretty_dio_logger.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {

  @singleton
  DioTokenInterceptor get dioTokenInterceptor => DioTokenInterceptor();

  @singleton
  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: true,
    maxWidth: 120,
  );

  @singleton
  Dio dio(DioTokenInterceptor interceptor, PrettyDioLogger logger) => _createDio(interceptor, logger);

  Dio _createDio(DioTokenInterceptor interceptor, PrettyDioLogger logger) {
    final dio = Dio(BaseOptions(baseUrl: AppConstants.baseApiUrl));
    dio.interceptors.add(interceptor);

    if (!AppConstants.appIsInReleaseMode) {
      dio.interceptors.add(logger);
    }
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);
    dio.options.sendTimeout = const Duration(milliseconds: 60000);

    return dio;
  }
}
