import 'package:eks_sana_plus_org/src/features/cartable/data/models/cartable_item_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/get_cartable_items_param_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/get_subordinated_users_param_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/subordinated_user_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class CartableDataSource {
  Future<BaseListResponse<SubordinatedUserModel>> getSubordinatedUsers(GetSubordinatedUsersParamModel param);

  Future<BaseListResponse<CartableItemModel>> getCartableItemList(
      GetCartableItemParamModel param);
}
