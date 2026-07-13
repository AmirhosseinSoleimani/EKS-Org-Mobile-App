import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/update_emdad_vehicle_param_entity.dart';

class UpdateEmdadVehicleParamModel extends UpdateEmdadVehicleParamEntity {
  const UpdateEmdadVehicleParamModel({
    super.vehicleModelId,
    super.isDepotEnabled,
    super.tashimType,
    super.id,
    super.chassisNumber,
    super.imeiId,
    super.engineNumber,
    super.isActive,
    super.productYear,
    super.isTroubleShooter,
    super.licensePlate,
    super.installTypeDate,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'vehicleModelId': vehicleModelId,
      'isDepotEnabled': isDepotEnabled,
      'tashimType': tashimType,
      'id': id,
      'chassisNumber': chassisNumber,
      'imeiid': imeiId,
      'engineNumber': engineNumber,
      'isActive': isActive,
      'productYear': productYear,
      'isTroubleShooter': isTroubleShooter,
      'licensePlate': licensePlate,
      'installTypeDate': installTypeDate,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
