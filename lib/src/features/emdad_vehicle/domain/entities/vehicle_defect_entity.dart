import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_defect_model.dart';

class VehicleDefectEntity {
  final int? id;
  final int? parentCode;
  final String? title;
  final bool? selected;
  final bool? isActive;

  const VehicleDefectEntity({
    this.id,
    this.parentCode,
    this.title,
    this.selected,
    this.isActive,
  });

  VehicleDefectModel toModel() {
    return VehicleDefectModel(
      id: id,
      parentCode: parentCode,
      title: title,
      selected: selected,
      isActive: isActive,
    );
  }

  VehicleDefectEntity copyWith({
    int? id,
    int? parentCode,
    String? title,
    bool? selected,
    bool? isActive,
  }) {
    return VehicleDefectEntity(
      id: id ?? this.id,
      parentCode: parentCode ?? this.parentCode,
      title: title ?? this.title,
      selected: selected ?? this.selected,
      isActive: isActive ?? this.isActive,
    );
  }
}
