import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/delegate_cartable_message_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/delegate_cartable_message_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_cartable_items_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class CartableRepository {
  Future<ApiResult<List<SubordinatedUserEntity>>> getSubordinatedUsers(
    GetSubordinatedUsersParamEntity param,
  );

  Future<ApiResult<List<CartableItemEntity>>> getCartableItemList(
      GetCartableItemParamEntity param);

  Future<ApiResult<DelegateCartableMessageResponseEntity>>
      delegateCartableMessage(DelegateCartableMessageParamEntity param);
}

