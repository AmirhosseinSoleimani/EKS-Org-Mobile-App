import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_tools_param_entity.dart';

class GetVehicleToolsParamModel extends GetVehicleToolsParamEntity {
  const GetVehicleToolsParamModel({
    super.vehicleId,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'vehicleId': vehicleId,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
