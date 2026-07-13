import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_history_param_model.dart';

class GetVehicleHistoryParamEntity {
  final int? refId;

  const GetVehicleHistoryParamEntity({
    this.refId,
  });

  GetVehicleHistoryParamModel toModel() {
    return GetVehicleHistoryParamModel(
      refId: refId,
    );
  }

  GetVehicleHistoryParamEntity copyWith({
    int? refId,
  }) {
    return GetVehicleHistoryParamEntity(
      refId: refId ?? this.refId,
    );
  }
}
