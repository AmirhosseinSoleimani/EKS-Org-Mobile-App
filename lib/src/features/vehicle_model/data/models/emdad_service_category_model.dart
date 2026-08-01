import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';

class EmdadServiceCategoryModel extends EmdadServiceCategoryEntity {
  const EmdadServiceCategoryModel({
    super.id,
    super.title,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.selected,
  });

  factory EmdadServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceCategoryModel(
      id: VehicleModelJsonHelper.integer(json['id'] ?? json['Id']),
      title: VehicleModelJsonHelper.string(json['title'] ?? json['Title']),
      serviceTypeId: VehicleModelJsonHelper.integer(
        json['serviceTypeId'] ?? json['ServiceTypeId'],
      ),
      serviceTypeTitle: VehicleModelJsonHelper.string(
        json['serviceTypeTitle'] ?? json['ServiceTypeTitle'],
      ),
      selected: VehicleModelJsonHelper.boolean(
            json['selected'] ?? json['Selected'],
          ) ??
          false,
    );
  }
}
