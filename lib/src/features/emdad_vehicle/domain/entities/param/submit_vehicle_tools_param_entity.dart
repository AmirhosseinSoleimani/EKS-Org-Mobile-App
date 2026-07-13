import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/submit_vehicle_tools_param_model.dart';

class SubmitVehicleToolsParamEntity {
  final List<int>? emdadToolsIds;
  final int? vehicleId;

  const SubmitVehicleToolsParamEntity({
    this.emdadToolsIds,
    this.vehicleId,
  });

  SubmitVehicleToolsParamModel toModel() {
    return SubmitVehicleToolsParamModel(
      emdadToolsIds: emdadToolsIds,
      vehicleId: vehicleId,
    );
  }

  SubmitVehicleToolsParamEntity copyWith({
    List<int>? emdadToolsIds,
    int? vehicleId,
  }) {
    return SubmitVehicleToolsParamEntity(
      emdadToolsIds: emdadToolsIds ?? this.emdadToolsIds,
      vehicleId: vehicleId ?? this.vehicleId,
    );
  }
}
