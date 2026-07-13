import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_defect_entity.dart';

class VehicleDefectModel extends VehicleDefectEntity {
  const VehicleDefectModel({
    super.id,
    super.parentCode,
    super.title,
    super.selected,
    super.isActive,
  });

  factory VehicleDefectModel.fromJson(Map<String, dynamic> json) {
    return VehicleDefectModel(
      id: json['id'] as int?,
      parentCode: json['parentCode'] as int?,
      title: json['title'] as String?,
      selected: json['selected'] as bool?,
      isActive: json['isActive'] as bool?,
    );
  }

  static List<VehicleDefectModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => VehicleDefectModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentCode': parentCode,
      'title': title,
      'selected': selected,
      'isActive': isActive,
    };
  }
}
