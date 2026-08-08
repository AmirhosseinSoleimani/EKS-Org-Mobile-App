import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/change_password_request_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class ProfileRepository {
  Future<ApiResult<String>> changePassword(ChangePasswordRequestEntity entity);

  Future<ApiResult<String>> logOff();
}
