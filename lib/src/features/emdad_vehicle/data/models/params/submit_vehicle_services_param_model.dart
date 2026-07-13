import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_services_param_entity.dart';

class SubmitVehicleServicesParamModel extends SubmitVehicleServicesParamEntity {
  const SubmitVehicleServicesParamModel({
    super.vehicleId,
    super.emdadServiceCategoryIds,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'vehicleId': vehicleId,
      'emdadServiceCategoryIds': emdadServiceCategoryIds,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
