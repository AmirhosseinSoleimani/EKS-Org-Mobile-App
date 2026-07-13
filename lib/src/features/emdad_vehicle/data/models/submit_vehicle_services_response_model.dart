import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/submit_vehicle_services_response_entity.dart';

class SubmitVehicleServicesResponseModel
    extends SubmitVehicleServicesResponseEntity {
  const SubmitVehicleServicesResponseModel();

  factory SubmitVehicleServicesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return const SubmitVehicleServicesResponseModel();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }
}
