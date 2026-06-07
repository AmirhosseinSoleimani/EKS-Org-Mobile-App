import 'package:eks_sana_plus_org/src/features/evaluation/data/models/allowable_cost_center_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class AllowableCostCenterEntity implements DropdownItem<int?> {
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

  @override
  String get label => name ?? '';

  @override
  int? get value => id;

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

  @override
  Widget? leading(BuildContext context) => null;
}