import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_id_request_model.dart';

class DeploymentLocationIdParamEntity {
  const DeploymentLocationIdParamEntity({required this.id});

  final int id;

  DeploymentLocationIdRequestModel toModel() {
    return DeploymentLocationIdRequestModel(id: id);
  }
}
