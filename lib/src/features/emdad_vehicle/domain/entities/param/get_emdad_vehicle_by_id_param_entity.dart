import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_emdad_vehicle_by_id_param_model.dart';

class GetEmdadVehicleByIdParamEntity {
  final int? id;

  const GetEmdadVehicleByIdParamEntity({
    this.id,
  });

  GetEmdadVehicleByIdParamModel toModel() {
    return GetEmdadVehicleByIdParamModel(
      id: id,
    );
  }

  GetEmdadVehicleByIdParamEntity copyWith({
    int? id,
  }) {
    return GetEmdadVehicleByIdParamEntity(
      id: id ?? this.id,
    );
  }
}
