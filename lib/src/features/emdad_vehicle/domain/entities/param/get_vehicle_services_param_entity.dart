import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_services_param_model.dart';

class GetVehicleServicesParamEntity {
  final int? id;

  const GetVehicleServicesParamEntity({
    this.id,
  });

  GetVehicleServicesParamModel toModel() {
    return GetVehicleServicesParamModel(
      id: id,
    );
  }

  GetVehicleServicesParamEntity copyWith({
    int? id,
  }) {
    return GetVehicleServicesParamEntity(
      id: id ?? this.id,
    );
  }
}
