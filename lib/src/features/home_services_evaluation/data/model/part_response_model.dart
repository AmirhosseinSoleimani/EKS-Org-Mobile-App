import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';

class PartResponseModel extends PartResponseEntity {
  PartResponseModel({
    super.allowableCostCenterList,
    super.garantyDurationDayKilometer,
    super.garantyKilometerKilometer,
    super.name,
    super.partGroupId,
    super.partGroupName,
    super.serial,
    super.mark
  });

  factory PartResponseModel.fromJson(Map<String, dynamic> json) {
    return PartResponseModel(
      name: json['name'],
      mark: json['mark'],
      partGroupName: json['partGroupName'],
      serial: json['serial'],
      garantyDurationDayKilometer: json['garantyDurationDayKilometer'],
      garantyKilometerKilometer: json['garantyKilometerKilometer'],
      partGroupId: json['partGroupId'],
      allowableCostCenterList: json['allowableCostCenterList'] != null ? (json['allowableCostCenterList'] as List).map((e) => CostCenterModel.fromJson(e)).toList() : [],
    );
  }
}
