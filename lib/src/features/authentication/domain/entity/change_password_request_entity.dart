import 'package:eks_sana_plus_org/src/features/authentication/data/models/change_password_request_model.dart';

class ChangePasswordRequestEntity {
  const ChangePasswordRequestEntity({
    required this.oldPassword,
    required this.newPassword,
  });

  final String oldPassword;
  final String newPassword;

  ChangePasswordRequestModel toModel() {
    return ChangePasswordRequestModel(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
