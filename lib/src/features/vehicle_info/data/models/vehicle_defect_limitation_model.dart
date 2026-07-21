import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_defect_limitation_entity.dart';

class VehicleDefectLimitationModel extends VehicleDefectLimitationEntity {
  const VehicleDefectLimitationModel({
    required super.id,
    super.parentCode,
    required super.title,
    super.selected,
  });

  factory VehicleDefectLimitationModel.fromJson(Map<String, dynamic> json) {
    return VehicleDefectLimitationModel(
      id: json['id'] as int? ?? 0,
      parentCode: json['parentCode']?.toString(),
      title: json['title'] as String? ?? '',
      selected: json['selected'] as bool? ?? false,
    );
  }
}
