import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/delete_emdad_vehicle_param_model.dart';

class DeleteEmdadVehicleParamEntity {
  final int? id;

  const DeleteEmdadVehicleParamEntity({
    this.id,
  });

  DeleteEmdadVehicleParamModel toModel() {
    return DeleteEmdadVehicleParamModel(
      id: id,
    );
  }

  DeleteEmdadVehicleParamEntity copyWith({
    int? id,
  }) {
    return DeleteEmdadVehicleParamEntity(
      id: id ?? this.id,
    );
  }
}
