import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity{
  const LoginRequestModel({
    super.otpCode,
    super.fcmToken,
  });

  Map<String, dynamic> toJson() => {
    'FcmToken': fcmToken,
    'OTP': otpCode,
  };
}