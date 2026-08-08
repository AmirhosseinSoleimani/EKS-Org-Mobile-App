import 'package:eks_sana_plus_org/src/features/authentication/data/models/change_password_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseSingleResponse<String>> changePassword(
    ChangePasswordRequestModel model,
  );

  Future<BaseSingleResponse<String>> logOff();
}
