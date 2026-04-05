import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/send_otp_code_request_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';

abstract class AuthRepository {

  Future<ApiResult> sendOTPCode(SendOtpCodeRequestEntity? entity);

  Future<ApiResult<UserEntity?>> login(LoginRequestEntity? entity);

}
