import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_response_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/service/auth_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthService _service;

  AuthRemoteDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<SendOtpCodeResponseModel?>> sendOtpCode(SendOtpCodeRequestModel? model) async {
    final result = await _service.sendOtpCode(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<UserModel?>> login(LoginRequestModel? model) async {
    final result = await _service.login(model?.toJson() ?? {});
    return result;
  }
}
