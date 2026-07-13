import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/emdad_vehicle_info_model.dart';

class EmdadVehicleInfoEntity {
  final int? id;
  final int? imeiId;
  final String? licensePlate;
  final String? chassisNumber;
  final String? engineNumber;
  final int? vehicleStatus;
  final String? vehicleStatusTitle;
  final String? productYear;
  final int? vehicleModelId;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? installTypeDate;
  final String? installTypeDateJalali;
  final bool? isTroubleShooter;
  final int? tashimType;
  final String? tashimTypeTitle;
  final bool? isDeleted;
  final bool? isActive;
  final bool? isDepotEnabled;

  const EmdadVehicleInfoEntity({
    this.id,
    this.imeiId,
    this.licensePlate,
    this.chassisNumber,
    this.engineNumber,
    this.vehicleStatus,
    this.vehicleStatusTitle,
    this.productYear,
    this.vehicleModelId,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.installTypeDate,
    this.installTypeDateJalali,
    this.isTroubleShooter,
    this.tashimType,
    this.tashimTypeTitle,
    this.isDeleted,
    this.isActive,
    this.isDepotEnabled,
  });

  EmdadVehicleInfoModel toModel() {
    return EmdadVehicleInfoModel(
      id: id,
      imeiId: imeiId,
      licensePlate: licensePlate,
      chassisNumber: chassisNumber,
      engineNumber: engineNumber,
      vehicleStatus: vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle,
      productYear: productYear,
      vehicleModelId: vehicleModelId,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      installTypeDate: installTypeDate,
      installTypeDateJalali: installTypeDateJalali,
      isTroubleShooter: isTroubleShooter,
      tashimType: tashimType,
      tashimTypeTitle: tashimTypeTitle,
      isDeleted: isDeleted,
      isActive: isActive,
      isDepotEnabled: isDepotEnabled,
    );
  }

  EmdadVehicleInfoEntity copyWith({
    int? id,
    int? imeiId,
    String? licensePlate,
    String? chassisNumber,
    String? engineNumber,
    int? vehicleStatus,
    String? vehicleStatusTitle,
    String? productYear,
    int? vehicleModelId,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? installTypeDate,
    String? installTypeDateJalali,
    bool? isTroubleShooter,
    int? tashimType,
    String? tashimTypeTitle,
    bool? isDeleted,
    bool? isActive,
    bool? isDepotEnabled,
  }) {
    return EmdadVehicleInfoEntity(
      id: id ?? this.id,
      imeiId: imeiId ?? this.imeiId,
      licensePlate: licensePlate ?? this.licensePlate,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      vehicleStatus: vehicleStatus ?? this.vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle ?? this.vehicleStatusTitle,
      productYear: productYear ?? this.productYear,
      vehicleModelId: vehicleModelId ?? this.vehicleModelId,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      installTypeDate: installTypeDate ?? this.installTypeDate,
      installTypeDateJalali: installTypeDateJalali ?? this.installTypeDateJalali,
      isTroubleShooter: isTroubleShooter ?? this.isTroubleShooter,
      tashimType: tashimType ?? this.tashimType,
      tashimTypeTitle: tashimTypeTitle ?? this.tashimTypeTitle,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      isDepotEnabled: isDepotEnabled ?? this.isDepotEnabled,
    );
  }
}
