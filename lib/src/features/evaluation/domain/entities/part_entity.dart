import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

import '../../data/models/part_model.dart';
import 'allowable_cost_center_entity.dart';

class PartEntity implements DropdownItem<String?>{
  final int? id;
  final String? name;
  final String? serial;
  final List<AllowableCostCenterEntity>? allowableCostCenterList;
  final int? garantyDurationDayKilometer;
  final int? garantyKilometerKilometer;
  final int? partGroupId;
  final String? partGroupName;

  const PartEntity({
    this.id,
    this.name,
    this.serial,
    this.allowableCostCenterList,
    this.garantyDurationDayKilometer,
    this.garantyKilometerKilometer,
    this.partGroupId,
    this.partGroupName,
  });

  PartModel toModel() {
    return PartModel(
      id: id,
      name: name,
      serial: serial,
      allowableCostCenterList:
      allowableCostCenterList?.map((e) => e.toModel()).toList(),
      garantyDurationDayKilometer: garantyDurationDayKilometer,
      garantyKilometerKilometer: garantyKilometerKilometer,
      partGroupId: partGroupId,
      partGroupName: partGroupName,
    );
  }

  PartEntity copyWith({
    int? id,
    String? name,
    String? serial,
    List<AllowableCostCenterEntity>? allowableCostCenterList,
    int? garantyDurationDayKilometer,
    int? garantyKilometerKilometer,
    int? partGroupId,
    String? partGroupName,
  }) {
    return PartEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      serial: serial ?? this.serial,
      allowableCostCenterList:
      allowableCostCenterList ?? this.allowableCostCenterList,
      garantyDurationDayKilometer:
      garantyDurationDayKilometer ?? this.garantyDurationDayKilometer,
      garantyKilometerKilometer:
      garantyKilometerKilometer ?? this.garantyKilometerKilometer,
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupName: partGroupName ?? this.partGroupName,
    );
  }

  @override
  String get label => name ?? '';

  @override
  String? get value => (id != null && id! > 0) ? id.toString() : serial;

  @override
  Widget? leading(BuildContext context) => null;

}