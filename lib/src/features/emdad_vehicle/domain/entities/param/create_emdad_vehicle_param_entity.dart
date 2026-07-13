import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/create_emdad_vehicle_param_model.dart';

class CreateEmdadVehicleParamEntity {
  final int? vehicleModelId;
  final String? chassisNumber;
  final int? imeiId;
  final String? engineNumber;
  final bool? isActive;
  final String? productYear;
  final bool? isTroubleShooter;
  final String? licensePlate;
  final String? installTypeDate;

  const CreateEmdadVehicleParamEntity({
    this.vehicleModelId,
    this.chassisNumber,
    this.imeiId,
    this.engineNumber,
    this.isActive,
    this.productYear,
    this.isTroubleShooter,
    this.licensePlate,
    this.installTypeDate,
  });

  CreateEmdadVehicleParamModel toModel() {
    return CreateEmdadVehicleParamModel(
      vehicleModelId: vehicleModelId,
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

  CreateEmdadVehicleParamEntity copyWith({
    int? vehicleModelId,
    String? chassisNumber,
    int? imeiId,
    String? engineNumber,
    bool? isActive,
    String? productYear,
    bool? isTroubleShooter,
    String? licensePlate,
    String? installTypeDate,
  }) {
    return CreateEmdadVehicleParamEntity(
      vehicleModelId: vehicleModelId ?? this.vehicleModelId,
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
