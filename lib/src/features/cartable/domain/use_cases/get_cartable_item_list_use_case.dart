import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_cartable_items_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/repositories/cartable_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCartableItemListUseCase
    extends
        BaseUseCase<
          ApiResult<List<CartableItemEntity>>,
          GetCartableItemParamEntity
        > {
  final CartableRepository _repository;

  GetCartableItemListUseCase(this._repository);

  @override
  Future<ApiResult<List<CartableItemEntity>>> call(arg) async {
    return await _repository.getCartableItemList(arg);
  }
}
