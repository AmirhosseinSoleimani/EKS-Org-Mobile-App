import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/repository/deployment_location_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDeploymentLocationByIdUseCase extends BaseUseCase<
    ApiResult<DeploymentLocationEntity>,
    DeploymentLocationIdParamEntity> {
  GetDeploymentLocationByIdUseCase(this._repository);

  final DeploymentLocationRepository _repository;

  @override
  Future<ApiResult<DeploymentLocationEntity>> call(
    DeploymentLocationIdParamEntity arg,
  ) => _repository.getById(arg);
}
