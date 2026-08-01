import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';

class VehicleModelModel extends VehicleModelEntity {
  const VehicleModelModel({
    super.id,
    super.name,
    super.code,
    super.navganTypeId,
    super.navganTypeTitle,
    super.navganTypeCode,
    super.title,
    super.isActive,
    super.isDeleted,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.hasDepot,
  });

  factory VehicleModelModel.fromJson(Map<String, dynamic> json) {
    return VehicleModelModel(
      id: VehicleModelJsonHelper.integer(json['id'] ?? json['Id']),
      name: VehicleModelJsonHelper.string(json['name'] ?? json['Name']),
      code: VehicleModelJsonHelper.string(json['code'] ?? json['Code']),
      navganTypeId: VehicleModelJsonHelper.integer(
        json['navganTypeId'] ?? json['NavganTypeId'],
      ),
      navganTypeTitle: VehicleModelJsonHelper.string(
        json['navganTypeTitle'] ?? json['NavganTypeTitle'],
      ),
      navganTypeCode: VehicleModelJsonHelper.string(
        json['navganTypeCode'] ?? json['NavganTypeCode'],
      ),
      title: VehicleModelJsonHelper.string(json['title'] ?? json['Title']),
      isActive: VehicleModelJsonHelper.boolean(
        json['isActive'] ?? json['IsActive'],
      ),
      isDeleted: VehicleModelJsonHelper.boolean(
        json['isDeleted'] ?? json['IsDeleted'],
      ),
      insertUserFullName: VehicleModelJsonHelper.string(
        json['insertUserFullName'] ?? json['InsertUserFullName'],
      ),
      updateUserFullName: VehicleModelJsonHelper.string(
        json['updateUserFullName'] ?? json['UpdateUserFullName'],
      ),
      insertDateTime: VehicleModelJsonHelper.string(
        json['insertDateTime'] ?? json['InsertDateTime'],
      ),
      insertDateTimeJalali: VehicleModelJsonHelper.string(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      hasDepot: VehicleModelJsonHelper.boolean(
        json['hasDepot'] ?? json['HasDepot'],
      ),
    );
  }
}
