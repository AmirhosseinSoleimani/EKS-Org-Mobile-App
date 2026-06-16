
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_cost_center_model.dart';

class InsertHomeServiceCostCenterEntity {
  final String? name;
  final String? code;
  final int? id;

  const InsertHomeServiceCostCenterEntity({this.name, this.code, this.id});

  InsertHomeServiceCostCenterEntity copyWith({
    String? name,
    String? code,
    int? id,
  }) {
    return InsertHomeServiceCostCenterEntity(
      name: name ?? this.name,
      code: code ?? this.code,
      id: id ?? this.id,
    );
  }

  InsertHomeServiceCostCenterModel toModel() {
    return InsertHomeServiceCostCenterModel(
      id: id,
      name: name,
      code: code,
    );
  }
}