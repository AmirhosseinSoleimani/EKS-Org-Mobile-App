import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'auth_service.g.dart';

@RestApi()
@lazySingleton
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST('/api/User/Login')
  Future<HttpResponse<BaseSingleResponse<LoginResponseModel?>>> login(@Body() Map<String, dynamic> body);

  @POST('/api/User/CurrentSession')
  Future<BaseSingleResponse<CurrentSessionModel?>> getCurrentSession(
      @Body() Map<String, dynamic> body);
}
