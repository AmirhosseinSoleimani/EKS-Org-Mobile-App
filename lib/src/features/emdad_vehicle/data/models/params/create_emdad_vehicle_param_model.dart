import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/create_emdad_vehicle_param_entity.dart';

class CreateEmdadVehicleParamModel extends CreateEmdadVehicleParamEntity {
  const CreateEmdadVehicleParamModel({
    super.vehicleModelId,
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
      'chassisNumber': chassisNumber,
      'imeiid': imeiId,
      'engineNumber': engineNumber,
      'isActive': isActive?.toString(),
      'productYear': productYear,
      'isTroubleShooter': isTroubleShooter,
      'licensePlate': licensePlate,
      'installTypeDate': installTypeDate,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
