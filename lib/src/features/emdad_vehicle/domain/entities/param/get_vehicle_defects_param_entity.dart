import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_defects_param_model.dart';

class GetVehicleDefectsParamEntity {
  final int? vehicleInfoId;
  final int? emdadServiceCategoryId;

  const GetVehicleDefectsParamEntity({
    this.vehicleInfoId,
    this.emdadServiceCategoryId,
  });

  GetVehicleDefectsParamModel toModel() {
    return GetVehicleDefectsParamModel(
      vehicleInfoId: vehicleInfoId,
      emdadServiceCategoryId: emdadServiceCategoryId,
    );
  }

  GetVehicleDefectsParamEntity copyWith({
    int? vehicleInfoId,
    int? emdadServiceCategoryId,
  }) {
    return GetVehicleDefectsParamEntity(
      vehicleInfoId: vehicleInfoId ?? this.vehicleInfoId,
      emdadServiceCategoryId: emdadServiceCategoryId ?? this.emdadServiceCategoryId,
    );
  }
}
