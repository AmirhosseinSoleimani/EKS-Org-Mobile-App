import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';

class LoginResponseEntity {
  const LoginResponseEntity({
    this.token,
  });

  final String? token;

  LoginResponseEntity copyWith({
    String? token,
  }) {
    return LoginResponseEntity(
      token: token ?? this.token,
    );
  }

  LoginResponseModel toModel() {
    return LoginResponseModel(
      token: token,
    );
  }
}