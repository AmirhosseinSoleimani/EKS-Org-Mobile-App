import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/repository/deployment_location_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteDeploymentLocationUseCase extends BaseUseCase<
    ApiResult<String>,
    DeploymentLocationIdParamEntity> {
  DeleteDeploymentLocationUseCase(this._repository);

  final DeploymentLocationRepository _repository;

  @override
  Future<ApiResult<String>> call(DeploymentLocationIdParamEntity arg) =>
      _repository.deleteById(arg);
}
