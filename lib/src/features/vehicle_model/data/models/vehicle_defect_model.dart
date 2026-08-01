import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_defect_entity.dart';

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
      id: VehicleModelJsonHelper.integer(json['id'] ?? json['Id']),
      parentCode: VehicleModelJsonHelper.integer(
        json['parentCode'] ?? json['ParentCode'],
      ),
      title: VehicleModelJsonHelper.string(json['title'] ?? json['Title']),
      selected: VehicleModelJsonHelper.boolean(
            json['selected'] ?? json['Selected'],
          ) ??
          false,
      isActive: VehicleModelJsonHelper.boolean(
        json['isActive'] ?? json['IsActive'],
      ),
    );
  }
}
