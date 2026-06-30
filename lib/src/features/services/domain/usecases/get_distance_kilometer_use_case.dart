import 'package:eks_sana_plus_org/src/features/services/domain/entities/distance_kilometer_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDistanceKilometerUseCase
    extends
        BaseUseCase<
          ApiResult<DistanceKilometerEntity>,
          DistanceKilometerParamEntity
        > {
  final RequestRepository _repository;

  GetDistanceKilometerUseCase(this._repository);

  @override
  Future<ApiResult<DistanceKilometerEntity>> call(arg) async {
    return await _repository.getDistanceKilometer(arg);
  }
}
