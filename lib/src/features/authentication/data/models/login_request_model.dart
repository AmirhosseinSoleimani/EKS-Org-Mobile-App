import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity{
  const LoginRequestModel({
    super.userName,
    super.password,
  });

  Map<String, dynamic> toJson() => {
    'username': userName,
    'password': password,
  };
}