import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/change_password_request_entity.dart';

class ChangePasswordRequestModel extends ChangePasswordRequestEntity {
  const ChangePasswordRequestModel({
    required super.oldPassword,
    required super.newPassword,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'OldPassword': oldPassword,
      'NewPassword': newPassword,
    };
  }
}
