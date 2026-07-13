import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_tools_param_entity.dart';

class SubmitVehicleToolsParamModel extends SubmitVehicleToolsParamEntity {
  const SubmitVehicleToolsParamModel({
    super.emdadToolsIds,
    super.vehicleId,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'emdadToolsIds': emdadToolsIds,
      'vehicleId': vehicleId,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
