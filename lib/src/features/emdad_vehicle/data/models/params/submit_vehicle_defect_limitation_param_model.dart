import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_defect_limitation_param_entity.dart';

class SubmitVehicleDefectLimitationParamModel extends SubmitVehicleDefectLimitationParamEntity {
  const SubmitVehicleDefectLimitationParamModel({
    super.vehicleId,
    super.serviceCategoryId,
    super.defectInfoIds,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'vehicleId': vehicleId,
      'serviceCategoryId': serviceCategoryId,
      'defectInfoIds': defectInfoIds,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
