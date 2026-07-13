import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_id_response_model.dart';

class VehicleIdResponseEntity {
  final String? id;

  const VehicleIdResponseEntity({
    this.id,
  });

  VehicleIdResponseModel toModel() {
    return VehicleIdResponseModel(
      id: id,
    );
  }

  VehicleIdResponseEntity copyWith({
    String? id,
  }) {
    return VehicleIdResponseEntity(
      id: id ?? this.id,
    );
  }
}
