import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_enums_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_menu_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_misc_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_role_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';

class CurrentSessionModel extends CurrentSessionEntity {
  const CurrentSessionModel({
    super.guid,
    super.authenticationType,
    super.firstName,
    super.lastName,
    super.fullName,
    super.nationalCode,
    super.mobileNo,
    super.email,
    super.userName,
    super.language,
    super.roles,
    super.authorizations,
    super.menus,
    super.misc,
    super.enums,
  });

  factory CurrentSessionModel.fromJson(Map<String, dynamic> json) {
    return CurrentSessionModel(
      guid: json['guid']?.toString(),
      authenticationType: _toInt(json['authenticationType']),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      fullName: json['fullName']?.toString(),
      nationalCode: json['nationalCode']?.toString(),
      mobileNo: json['mobileNo']?.toString(),
      email: json['email']?.toString(),
      userName: json['userName']?.toString(),
      language: _toInt(json['language']),
      roles: (json['roles'] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map(CurrentSessionRoleModel.fromJson)
          .toList(),
      authorizations: (json['authorizations'] as List?)
          ?.map((item) => item.toString())
          .toList(),
      menus: (json['menus'] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map(CurrentSessionMenuModel.fromJson)
          .toList(),
      misc: json['misc'] is Map<String, dynamic>
          ? CurrentSessionMiscModel.fromJson(
              json['misc'] as Map<String, dynamic>,
            )
          : null,
      enums: json['enums'] is Map<String, dynamic>
          ? CurrentSessionEnumsModel.fromJson(
              json['enums'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
