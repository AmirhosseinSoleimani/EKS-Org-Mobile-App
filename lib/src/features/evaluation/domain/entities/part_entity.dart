import '../../data/models/part_model.dart';
import 'allowable_cost_center_entity.dart';

class PartEntity {
  final String? name;
  final String? serial;
  final List<AllowableCostCenterEntity>? allowableCostCenterList;
  final int? garantyDurationDayKilometer;
  final int? garantyKilometerKilometer;
  final int? partGroupId;
  final String? partGroupName;

  const PartEntity({
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
    String? name,
    String? serial,
    List<AllowableCostCenterEntity>? allowableCostCenterList,
    int? garantyDurationDayKilometer,
    int? garantyKilometerKilometer,
    int? partGroupId,
    String? partGroupName,
  }) {
    return PartEntity(
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
}