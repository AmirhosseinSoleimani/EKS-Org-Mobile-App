import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_response_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponseEntity?>> login(LoginRequestEntity entity);

  Future<ApiResult<CurrentSessionEntity?>> getCurrentSession();

}
