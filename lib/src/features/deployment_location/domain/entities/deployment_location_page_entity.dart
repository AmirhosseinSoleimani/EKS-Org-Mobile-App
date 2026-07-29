import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';

class DeploymentLocationPageEntity {
  const DeploymentLocationPageEntity({
    this.records = const [],
    this.count = 0,
  });

  final List<DeploymentLocationEntity> records;
  final int count;
}
