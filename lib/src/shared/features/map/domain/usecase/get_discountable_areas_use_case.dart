import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/discountable_area_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDiscountableAreasUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<DiscountableAreaEntity>>> {
  GetDiscountableAreasUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<List<DiscountableAreaEntity>>> call() =>
      _repository.getDiscountableAreas();
}
