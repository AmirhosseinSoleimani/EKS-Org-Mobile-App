import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_role_entity.dart';

class CurrentSessionRoleModel extends CurrentSessionRoleEntity {
  const CurrentSessionRoleModel({super.code, super.name});

  factory CurrentSessionRoleModel.fromJson(Map<String, dynamic> json) {
    return CurrentSessionRoleModel(
      code: json['code']?.toString(),
      name: json['name']?.toString(),
    );
  }
}
