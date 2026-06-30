
import '../../data/models/current_session_role_model.dart';

class CurrentSessionRoleEntity {
  final String? code;
  final String? name;

  const CurrentSessionRoleEntity({
    this.code,
    this.name,
  });

  CurrentSessionRoleEntity copyWith({
    String? code,
    String? name,
  }) {
    return CurrentSessionRoleEntity(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  CurrentSessionRoleModel toModel() {
    return CurrentSessionRoleModel(
      code: code,
      name: name,
    );
  }
}
