import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';

class VehicleNavganModel extends VehicleNavganEntity {
  const VehicleNavganModel({
    super.id,
    super.emdadgarNavganType,
    super.title,
    super.code,
    super.isActive,
  });

  factory VehicleNavganModel.fromJson(Map<String, dynamic> json) {
    return VehicleNavganModel(
      id: VehicleModelJsonHelper.integer(json['id'] ?? json['Id']),
      emdadgarNavganType: VehicleModelJsonHelper.integer(
        json['emdadgarNavganType'] ?? json['EmdadgarNavganType'],
      ),
      title: VehicleModelJsonHelper.string(json['title'] ?? json['Title']),
      code: VehicleModelJsonHelper.string(json['code'] ?? json['Code']),
      isActive: VehicleModelJsonHelper.boolean(
        json['isActive'] ?? json['IsActive'],
      ),
    );
  }
}
