import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@lazySingleton
class GetLocationDataUseCase
    extends BaseUseCase<ApiResult<LocationData>, LocationEntity> {
  GetLocationDataUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<LocationData>> call(args) async {
    return await _repository.getLocationData(args);
  }
}
