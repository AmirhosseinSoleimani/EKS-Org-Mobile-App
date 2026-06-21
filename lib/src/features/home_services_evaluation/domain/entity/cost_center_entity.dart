import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class CostCenterEntity  implements DropdownItem<int?>{
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

  @override
  String get label => name ?? '';

  @override
  int? get value => id;

  @override
  Widget? leading(BuildContext context) => null;
}
