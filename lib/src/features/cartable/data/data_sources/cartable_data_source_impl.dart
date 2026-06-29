import 'package:eks_sana_plus_org/src/features/cartable/data/data_sources/cartable_data_source.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/get_subordinated_users_param_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/subordinated_user_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/service/cartable_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartableDataSource)
class CartableDataSourceImpl extends CartableDataSource {
  final CartableService _service;

  CartableDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<SubordinatedUserModel>> getSubordinatedUsers(
      GetSubordinatedUsersParamModel param) async
  => await _service.getSubordinatedUsers(param.toJson());

}
