import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/submit_vehicle_tools_response_model.dart';

class SubmitVehicleToolsResponseEntity {
  final String? message;

  const SubmitVehicleToolsResponseEntity({
    this.message,
  });

  SubmitVehicleToolsResponseModel toModel() {
    return SubmitVehicleToolsResponseModel(
      message: message,
    );
  }

  SubmitVehicleToolsResponseEntity copyWith({
    String? message,
  }) {
    return SubmitVehicleToolsResponseEntity(
      message: message ?? this.message,
    );
  }
}
