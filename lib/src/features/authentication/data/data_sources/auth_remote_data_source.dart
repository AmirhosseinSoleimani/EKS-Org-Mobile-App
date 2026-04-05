import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';

abstract class AuthRemoteDataSource {

  Future<BaseSingleResponse<SendOtpCodeResponseModel?>> sendOtpCode(SendOtpCodeRequestModel? model);

  Future<BaseSingleResponse<UserModel?>> login (LoginRequestModel? model);
}
