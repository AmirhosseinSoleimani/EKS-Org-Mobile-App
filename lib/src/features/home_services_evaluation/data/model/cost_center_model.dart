

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';

class CostCenterModel extends CostCenterEntity {
  CostCenterModel({
    super.code,
    super.id,
    super.name,
  });
  factory CostCenterModel.fromJson(Map<String, dynamic> json) {
    return CostCenterModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }
}