import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class CartableRepository {
  Future<ApiResult<List<SubordinatedUserEntity>>> getSubordinatedUsers(
    GetSubordinatedUsersParamEntity param,
  );
}
