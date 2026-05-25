

import 'package:eks_sana_plus_org/src/features/evaluation/data/models/allowable_cost_center_model.dart';

class AllowableCostCenterEntity {
  final int? id;
  final String? code;
  final String? name;
  final bool? selected;
  final int? nahveMohasebeType;

  const AllowableCostCenterEntity({
    this.id,
    this.code,
    this.name,
    this.selected,
    this.nahveMohasebeType,
  });

  AllowableCostCenterModel toModel() {
    return AllowableCostCenterModel(
      id: id,
      code: code,
      name: name,
      selected: selected,
      nahveMohasebeType: nahveMohasebeType,
    );
  }

  AllowableCostCenterEntity copyWith({
    int? id,
    String? code,
    String? name,
    bool? selected,
    int? nahveMohasebeType,
  }) {
    return AllowableCostCenterEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      selected: selected ?? this.selected,
      nahveMohasebeType: nahveMohasebeType ?? this.nahveMohasebeType,
    );
  }
}