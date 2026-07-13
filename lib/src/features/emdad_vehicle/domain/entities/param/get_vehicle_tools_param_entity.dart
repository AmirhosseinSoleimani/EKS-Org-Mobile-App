import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_tools_param_model.dart';

class GetVehicleToolsParamEntity {
  final int? vehicleId;

  const GetVehicleToolsParamEntity({
    this.vehicleId,
  });

  GetVehicleToolsParamModel toModel() {
    return GetVehicleToolsParamModel(
      vehicleId: vehicleId,
    );
  }

  GetVehicleToolsParamEntity copyWith({
    int? vehicleId,
  }) {
    return GetVehicleToolsParamEntity(
      vehicleId: vehicleId ?? this.vehicleId,
    );
  }
}
