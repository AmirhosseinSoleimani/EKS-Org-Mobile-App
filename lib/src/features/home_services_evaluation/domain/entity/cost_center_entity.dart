import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';

class CostCenterEntity {
  final String? name;
  final String? code;
  final int? id;

  CostCenterEntity({this.name, this.code, this.id});

  CostCenterEntity copyWith({String? name, String? code, int? id}) {
    return CostCenterEntity(
      name: name ?? this.name,
      code: code ?? this.code,
      id: id ?? this.id,
    );
  }

  CostCenterModel toModel() {
    return CostCenterModel(id: id, name: name, code: code);
  }
}
