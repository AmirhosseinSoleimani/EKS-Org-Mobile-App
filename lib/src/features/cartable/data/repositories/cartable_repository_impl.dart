import 'package:eks_sana_plus_org/src/features/cartable/data/data_sources/cartable_data_source.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/repositories/cartable_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartableRepository)
class CartableRepositoryImpl extends CartableRepository {
  final CartableDataSource _dataSource;

  CartableRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<SubordinatedUserEntity>>> getSubordinatedUsers(
    GetSubordinatedUsersParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getSubordinatedUsers(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
