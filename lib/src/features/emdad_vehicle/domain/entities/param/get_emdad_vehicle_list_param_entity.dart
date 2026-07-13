import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_emdad_vehicle_list_param_model.dart';

class GetEmdadVehicleListParamEntity {
  final int? vehicleModelId;
  final bool? isDepotEnabled;
  final int? tashimType;
  final String? chassisNumber;
  final String? engineNumber;
  final String? imeiSerial;
  final bool? isTroubleShooter;
  final bool? isActive;
  final String? licensePlateFirstPart;
  final String? licensePlateLetter;
  final String? licensePlateSecondPart;
  final String? licensePlateLastPart;
  final int? pageSize;
  final int? skip;

  const GetEmdadVehicleListParamEntity({
    this.vehicleModelId,
    this.isDepotEnabled,
    this.tashimType,
    this.chassisNumber,
    this.engineNumber,
    this.imeiSerial,
    this.isTroubleShooter,
    this.isActive,
    this.licensePlateFirstPart,
    this.licensePlateLetter,
    this.licensePlateSecondPart,
    this.licensePlateLastPart,
    this.pageSize,
    this.skip,
  });

  GetEmdadVehicleListParamModel toModel() {
    return GetEmdadVehicleListParamModel(
      vehicleModelId: vehicleModelId,
      isDepotEnabled: isDepotEnabled,
      tashimType: tashimType,
      chassisNumber: chassisNumber,
      engineNumber: engineNumber,
      imeiSerial: imeiSerial,
      isTroubleShooter: isTroubleShooter,
      isActive: isActive,
      licensePlateFirstPart: licensePlateFirstPart,
      licensePlateLetter: licensePlateLetter,
      licensePlateSecondPart: licensePlateSecondPart,
      licensePlateLastPart: licensePlateLastPart,
      pageSize: pageSize,
      skip: skip,
    );
  }

  GetEmdadVehicleListParamEntity copyWith({
    int? vehicleModelId,
    bool? isDepotEnabled,
    int? tashimType,
    String? chassisNumber,
    String? engineNumber,
    String? imeiSerial,
    bool? isTroubleShooter,
    bool? isActive,
    String? licensePlateFirstPart,
    String? licensePlateLetter,
    String? licensePlateSecondPart,
    String? licensePlateLastPart,
    int? pageSize,
    int? skip,
  }) {
    return GetEmdadVehicleListParamEntity(
      vehicleModelId: vehicleModelId ?? this.vehicleModelId,
      isDepotEnabled: isDepotEnabled ?? this.isDepotEnabled,
      tashimType: tashimType ?? this.tashimType,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      imeiSerial: imeiSerial ?? this.imeiSerial,
      isTroubleShooter: isTroubleShooter ?? this.isTroubleShooter,
      isActive: isActive ?? this.isActive,
      licensePlateFirstPart: licensePlateFirstPart ?? this.licensePlateFirstPart,
      licensePlateLetter: licensePlateLetter ?? this.licensePlateLetter,
      licensePlateSecondPart: licensePlateSecondPart ?? this.licensePlateSecondPart,
      licensePlateLastPart: licensePlateLastPart ?? this.licensePlateLastPart,
      pageSize: pageSize ?? this.pageSize,
      skip: skip ?? this.skip,
    );
  }
}
