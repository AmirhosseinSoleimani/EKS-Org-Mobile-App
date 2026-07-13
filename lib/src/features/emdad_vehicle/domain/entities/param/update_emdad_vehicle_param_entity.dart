import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/update_emdad_vehicle_param_model.dart';

class UpdateEmdadVehicleParamEntity {
  final int? vehicleModelId;
  final bool? isDepotEnabled;
  final int? tashimType;
  final int? id;
  final String? chassisNumber;
  final int? imeiId;
  final String? engineNumber;
  final bool? isActive;
  final String? productYear;
  final bool? isTroubleShooter;
  final String? licensePlate;
  final String? installTypeDate;

  const UpdateEmdadVehicleParamEntity({
    this.vehicleModelId,
    this.isDepotEnabled,
    this.tashimType,
    this.id,
    this.chassisNumber,
    this.imeiId,
    this.engineNumber,
    this.isActive,
    this.productYear,
    this.isTroubleShooter,
    this.licensePlate,
    this.installTypeDate,
  });

  UpdateEmdadVehicleParamModel toModel() {
    return UpdateEmdadVehicleParamModel(
      vehicleModelId: vehicleModelId,
      isDepotEnabled: isDepotEnabled,
      tashimType: tashimType,
      id: id,
      chassisNumber: chassisNumber,
      imeiId: imeiId,
      engineNumber: engineNumber,
      isActive: isActive,
      productYear: productYear,
      isTroubleShooter: isTroubleShooter,
      licensePlate: licensePlate,
      installTypeDate: installTypeDate,
    );
  }

  UpdateEmdadVehicleParamEntity copyWith({
    int? vehicleModelId,
    bool? isDepotEnabled,
    int? tashimType,
    int? id,
    String? chassisNumber,
    int? imeiId,
    String? engineNumber,
    bool? isActive,
    String? productYear,
    bool? isTroubleShooter,
    String? licensePlate,
    String? installTypeDate,
  }) {
    return UpdateEmdadVehicleParamEntity(
      vehicleModelId: vehicleModelId ?? this.vehicleModelId,
      isDepotEnabled: isDepotEnabled ?? this.isDepotEnabled,
      tashimType: tashimType ?? this.tashimType,
      id: id ?? this.id,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      imeiId: imeiId ?? this.imeiId,
      engineNumber: engineNumber ?? this.engineNumber,
      isActive: isActive ?? this.isActive,
      productYear: productYear ?? this.productYear,
      isTroubleShooter: isTroubleShooter ?? this.isTroubleShooter,
      licensePlate: licensePlate ?? this.licensePlate,
      installTypeDate: installTypeDate ?? this.installTypeDate,
    );
  }
}
