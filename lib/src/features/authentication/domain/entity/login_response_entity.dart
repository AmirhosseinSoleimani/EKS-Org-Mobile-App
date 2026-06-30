import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';

import 'menus_info_entity.dart';

class LoginResponseEntity {
  const LoginResponseEntity({
    this.token,
    this.menus,
  });

  final String? token;
  final List<MenuInfoEntity?>? menus;

  LoginResponseEntity copyWith({
    String? token,
    List<MenuInfoEntity?>? menus,
  }) {
    return LoginResponseEntity(
      token: token ?? this.token,
      menus: menus ?? this.menus,
    );
  }

  LoginResponseModel toModel() {
    return LoginResponseModel(
      token: token,
      menus: menus,
    );
  }
}