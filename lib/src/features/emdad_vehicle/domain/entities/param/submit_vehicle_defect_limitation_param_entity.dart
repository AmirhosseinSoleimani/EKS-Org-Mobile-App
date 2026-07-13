import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/submit_vehicle_defect_limitation_param_model.dart';

class SubmitVehicleDefectLimitationParamEntity {
  final int? vehicleId;
  final int? serviceCategoryId;
  final List<int>? defectInfoIds;

  const SubmitVehicleDefectLimitationParamEntity({
    this.vehicleId,
    this.serviceCategoryId,
    this.defectInfoIds,
  });

  SubmitVehicleDefectLimitationParamModel toModel() {
    return SubmitVehicleDefectLimitationParamModel(
      vehicleId: vehicleId,
      serviceCategoryId: serviceCategoryId,
      defectInfoIds: defectInfoIds,
    );
  }

  SubmitVehicleDefectLimitationParamEntity copyWith({
    int? vehicleId,
    int? serviceCategoryId,
    List<int>? defectInfoIds,
  }) {
    return SubmitVehicleDefectLimitationParamEntity(
      vehicleId: vehicleId ?? this.vehicleId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      defectInfoIds: defectInfoIds ?? this.defectInfoIds,
    );
  }
}
