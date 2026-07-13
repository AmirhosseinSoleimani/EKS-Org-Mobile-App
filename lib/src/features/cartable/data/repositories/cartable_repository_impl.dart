import 'package:eks_sana_plus_org/src/features/cartable/data/data_sources/cartable_data_source.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/archive_cartable_message_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/delegate_cartable_message_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/archive_cartable_message_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/delegate_cartable_message_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_cartable_items_param_entity.dart';
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

  @override
  Future<ApiResult<List<CartableItemEntity>>> getCartableItemList(GetCartableItemParamEntity param) async {
    try {
      final result = await _dataSource.getCartableItemList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
  @override
  Future<ApiResult<DelegateCartableMessageResponseEntity>>
      delegateCartableMessage(DelegateCartableMessageParamEntity param) async {
    try {
      final result = await _dataSource.delegateCartableMessage(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<
      ApiResult<ArchiveCartableMessageResponseEntity>> archiveCartableMessage(
      ArchiveCartableMessageParamEntity param) async {
    try {
      final result = await _dataSource.archiveCartableMessage(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

}
