import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'auth_service.g.dart';

@RestApi()
@lazySingleton
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST('/api/User/SendLoginOtp')
  Future<BaseSingleResponse<SendOtpCodeResponseModel?>> sendOtpCode(@Body() Map<String, dynamic> body);

  @POST('/api/User/Login')
  Future<BaseSingleResponse<UserModel?>> login(@Body() Map<String, dynamic> body);
}
