import '../../domain/entities/part_entity.dart';
import 'allowable_cost_center_model.dart';

class PartModel extends PartEntity {
  const PartModel({
    super.id,
    super.name,
    super.serial,
    super.allowableCostCenterList,
    super.garantyDurationDayKilometer,
    super.garantyKilometerKilometer,
    super.partGroupId,
    super.partGroupName,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      id: json['id'],
      name: json['name'],
      serial: json['serial'],
      allowableCostCenterList: json['allowableCostCenterList'] == null
          ? null
          : (json['allowableCostCenterList'] as List)
          .map((e) => AllowableCostCenterModel.fromJson(e).toEntity())
          .toList(),
      garantyDurationDayKilometer: json['garantyDurationDayKilometer'],
      garantyKilometerKilometer: json['garantyKilometerKilometer'],
      partGroupId: json['partGroupId'],
      partGroupName: json['partGroupName'],
    );
  }
}