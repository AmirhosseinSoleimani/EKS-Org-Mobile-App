import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_response_entity.dart';

import 'menus_info_model.dart';

class LoginResponseModel extends LoginResponseEntity{
  LoginResponseModel({
    super.token,
    super.menus,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['sessionId'],
      menus: json['menus'] == null ? [] : List<MenusInfoModel>.from(
        json['menus'].map((item) => MenusInfoModel.fromJson(item))),
    );
  }
}
