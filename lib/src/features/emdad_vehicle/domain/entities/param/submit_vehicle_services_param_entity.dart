import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/submit_vehicle_services_param_model.dart';

class SubmitVehicleServicesParamEntity {
  final int? vehicleId;
  final List<int>? emdadServiceCategoryIds;

  const SubmitVehicleServicesParamEntity({
    this.vehicleId,
    this.emdadServiceCategoryIds,
  });

  SubmitVehicleServicesParamModel toModel() {
    return SubmitVehicleServicesParamModel(
      vehicleId: vehicleId,
      emdadServiceCategoryIds: emdadServiceCategoryIds,
    );
  }

  SubmitVehicleServicesParamEntity copyWith({
    int? vehicleId,
    List<int>? emdadServiceCategoryIds,
  }) {
    return SubmitVehicleServicesParamEntity(
      vehicleId: vehicleId ?? this.vehicleId,
      emdadServiceCategoryIds: emdadServiceCategoryIds ?? this.emdadServiceCategoryIds,
    );
  }
}
