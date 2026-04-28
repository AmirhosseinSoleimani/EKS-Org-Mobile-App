import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAreaBaseInfoUseCase
    extends BaseUseCase<ApiResult<RouteDataEntity>, RouteParamEntity> {
  GetAreaBaseInfoUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<RouteDataEntity>> call(arg) async {
    return await _repository.getRoute(arg);
  }
}
