import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity{
  LoginResponseModel({
    super.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
    );
  }
}
