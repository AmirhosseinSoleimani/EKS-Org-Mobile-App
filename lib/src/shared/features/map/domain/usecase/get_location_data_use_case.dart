import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_data_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLocationDataUseCase
    extends BaseUseCase<ApiResult<LocationDataEntity>, LocationEntity> {
  GetLocationDataUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<LocationDataEntity>> call(args) async {
    return await _repository.getLocationData(args);
  }
}
