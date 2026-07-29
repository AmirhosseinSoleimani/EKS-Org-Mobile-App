import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_page_entity.dart';

class DeploymentLocationPageModel extends DeploymentLocationPageEntity {
  const DeploymentLocationPageModel({
    super.records,
    super.count,
  });

  factory DeploymentLocationPageModel.fromJson(Map<String, dynamic> json) {
    final records = DeploymentLocationJsonHelper.pageRecords(json)
        .map(DeploymentLocationModel.fromJson)
        .where((item) => item.id != null)
        .toList(growable: false);

    return DeploymentLocationPageModel(
      records: records,
      count: DeploymentLocationJsonHelper.pageCount(json),
    );
  }
}
