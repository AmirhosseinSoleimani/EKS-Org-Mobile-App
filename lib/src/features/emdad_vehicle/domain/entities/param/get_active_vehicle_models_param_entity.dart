import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_active_vehicle_models_param_model.dart';

class GetActiveVehicleModelsParamEntity {
  final int? pageSize;

  const GetActiveVehicleModelsParamEntity({
    this.pageSize,
  });

  GetActiveVehicleModelsParamModel toModel() {
    return GetActiveVehicleModelsParamModel(
      pageSize: pageSize,
    );
  }

  GetActiveVehicleModelsParamEntity copyWith({
    int? pageSize,
  }) {
    return GetActiveVehicleModelsParamEntity(
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
