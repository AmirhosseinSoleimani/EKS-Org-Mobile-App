import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';

class LoginRequestEntity {
  const LoginRequestEntity({
    this.userName,
    this.password,
    this.captchaGuid,
    this.captchaCode,
  });

  final String? userName;
  final String? password;
  final String? captchaGuid;
  final String? captchaCode;

  LoginRequestEntity copyWith({
    String? userName,
    String? password,
    String? captchaGuid,
    String? captchaCode,
  }) {
    return LoginRequestEntity(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      captchaGuid: captchaGuid ?? this.captchaGuid,
      captchaCode: captchaCode ?? this.captchaCode,
    );
  }

  LoginRequestModel toModel() {
    return LoginRequestModel(
      userName: userName,
      password: password,
      captchaGuid: captchaGuid,
      captchaCode: captchaCode,
    );
  }
}
