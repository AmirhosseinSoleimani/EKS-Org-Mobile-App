import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';

class LoginRequestEntity {
  const LoginRequestEntity({
    this.userName,
    this.password,
  });

  final String? userName;
  final String? password;

  LoginRequestEntity copyWith({
    String? otpCode,
    String? fcmToken,
  }) {
    return LoginRequestEntity(
      userName: otpCode ?? userName,
      password: fcmToken ?? password,
    );
  }

  LoginRequestModel toModel() {
    return LoginRequestModel(
      userName: userName,
      password: password,
    );
  }
}