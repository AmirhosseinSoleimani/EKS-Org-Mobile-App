import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/repository/deployment_location_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDeploymentLocationListUseCase extends BaseUseCase<
    ApiResult<DeploymentLocationPageEntity>,
    DeploymentLocationFilterParamEntity> {
  GetDeploymentLocationListUseCase(this._repository);

  final DeploymentLocationRepository _repository;

  @override
  Future<ApiResult<DeploymentLocationPageEntity>> call(
    DeploymentLocationFilterParamEntity arg,
  ) => _repository.getByFilter(arg);
}
