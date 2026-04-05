import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';

class LoginRequestEntity {
  const LoginRequestEntity({
    this.otpCode,
    this.fcmToken,
  });

  final String? otpCode;
  final String? fcmToken;

  LoginRequestEntity copyWith({
    String? otpCode,
    String? fcmToken,
  }) {
    return LoginRequestEntity(
      otpCode: otpCode ?? this.otpCode,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  LoginRequestModel toModel() {
    return LoginRequestModel(
      otpCode: otpCode,
      fcmToken: fcmToken,
    );
  }
}