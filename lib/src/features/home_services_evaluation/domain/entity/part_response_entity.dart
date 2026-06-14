import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_response_model.dart';

import 'cost_center_entity.dart';

class PartResponseEntity {
  String? name;
  String? serial;
  int? garantyDurationDayKilometer;
  int? garantyKilometerKilometer;
  int? partGroupId;
  String? partGroupName;
  String? mark;
  List<CostCenterEntity>? allowableCostCenterList;

  PartResponseModel toModel() {
    return PartResponseModel(
      name: name,
      serial: serial,
      garantyKilometerKilometer: garantyKilometerKilometer,
      garantyDurationDayKilometer: garantyDurationDayKilometer,
      partGroupId: partGroupId,
      partGroupName: partGroupName,
      mark: mark,
      allowableCostCenterList: allowableCostCenterList
          ?.map((e) => e.toModel())
          .toList(),
    );
  }

  PartResponseEntity copyWith({
    String? name,
    String? serial,
    int? garantyDurationDayKilometer,
    int? garantyKilometerKilometer,
    int? partGroupId,
    String? partGroupName,
    String? mark,
    List<CostCenterEntity>? allowableCostCenterList,
  }) {
    return PartResponseEntity(
      name: name ?? this.name,
      serial: serial ?? this.serial,
      garantyDurationDayKilometer:
          garantyDurationDayKilometer ?? this.garantyDurationDayKilometer,
      garantyKilometerKilometer:
          garantyKilometerKilometer ?? this.garantyKilometerKilometer,
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupName: partGroupName ?? this.partGroupName,
      mark: mark ?? this.mark,
      allowableCostCenterList:
          allowableCostCenterList ?? this.allowableCostCenterList,
    );
  }

  PartResponseEntity({
    this.name,
    this.serial,
    this.partGroupId,
    this.allowableCostCenterList,
    this.partGroupName,
    this.garantyDurationDayKilometer,
    this.garantyKilometerKilometer,
    this.mark,
  });
}
