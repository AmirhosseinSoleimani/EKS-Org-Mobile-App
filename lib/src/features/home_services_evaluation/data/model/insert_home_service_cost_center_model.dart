import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_cost_center_entity.dart';

class InsertHomeServiceCostCenterModel
    extends InsertHomeServiceCostCenterEntity {
  const InsertHomeServiceCostCenterModel({super.code, super.id, super.name});

  factory InsertHomeServiceCostCenterModel.fromJson(Map<String, dynamic> json) {
    return InsertHomeServiceCostCenterModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }
}
