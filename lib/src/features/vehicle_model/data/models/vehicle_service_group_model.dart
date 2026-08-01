import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';

class VehicleServiceGroupModel extends VehicleServiceGroupEntity {
  const VehicleServiceGroupModel({
    super.emdadCategories,
    super.serviceType,
    super.serviceTypeTitle,
  });

  factory VehicleServiceGroupModel.fromJson(Map<String, dynamic> json) {
    return VehicleServiceGroupModel(
      emdadCategories: VehicleModelJsonHelper.mapList(
        json['emdadCategories'] ?? json['EmdadCategories'],
      ).map(EmdadServiceCategoryModel.fromJson).toList(),
      serviceType: VehicleModelJsonHelper.integer(
        json['serviceType'] ?? json['ServiceType'],
      ),
      serviceTypeTitle: VehicleModelJsonHelper.string(
        json['serviceTypeTitle'] ?? json['ServiceTypeTitle'],
      ),
    );
  }
}
