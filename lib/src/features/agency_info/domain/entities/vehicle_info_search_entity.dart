import 'package:eks_sana_plus_org/src/features/agency_info/data/models/vehicle_info_search_model.dart';

class VehicleInfoSearchEntity {
  const VehicleInfoSearchEntity({
    this.id,
    this.imeiId,
    this.imeiSerial,
    this.licensePlate,
    this.chassisNumber,
    this.engineNumber,
    this.vehicleStatus,
    this.vehicleStatusTitle,
    this.productYear,
    this.vehicleModelId,
    this.vehicleModelTitle,
    this.vehicleModelName,
    this.navganCode,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.installTypeDate,
    this.installTypeDateJalali,
    this.isTroubleShooter,
    this.tashimType,
    this.tashimTypeTitle,
    this.isDeleted,
    this.isActive,
  });

  final int? id;
  final int? imeiId;
  final String? imeiSerial;
  final String? licensePlate;
  final String? chassisNumber;
  final String? engineNumber;
  final int? vehicleStatus;
  final String? vehicleStatusTitle;
  final String? productYear;
  final int? vehicleModelId;
  final String? vehicleModelTitle;
  final String? vehicleModelName;
  final String? navganCode;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? installTypeDate;
  final String? installTypeDateJalali;
  final bool? isTroubleShooter;
  final int? tashimType;
  final String? tashimTypeTitle;
  final bool? isDeleted;
  final bool? isActive;

  VehicleInfoSearchModel toModel() {
    return VehicleInfoSearchModel(
      id: id,
      imeiId: imeiId,
      imeiSerial: imeiSerial,
      licensePlate: licensePlate,
      chassisNumber: chassisNumber,
      engineNumber: engineNumber,
      vehicleStatus: vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle,
      productYear: productYear,
      vehicleModelId: vehicleModelId,
      vehicleModelTitle: vehicleModelTitle,
      vehicleModelName: vehicleModelName,
      navganCode: navganCode,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      installTypeDate: installTypeDate,
      installTypeDateJalali: installTypeDateJalali,
      isTroubleShooter: isTroubleShooter,
      tashimType: tashimType,
      tashimTypeTitle: tashimTypeTitle,
      isDeleted: isDeleted,
      isActive: isActive,
    );
  }

  VehicleInfoSearchEntity copyWith({
    int? id,
    int? imeiId,
    String? imeiSerial,
    String? licensePlate,
    String? chassisNumber,
    String? engineNumber,
    int? vehicleStatus,
    String? vehicleStatusTitle,
    String? productYear,
    int? vehicleModelId,
    String? vehicleModelTitle,
    String? vehicleModelName,
    String? navganCode,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? installTypeDate,
    String? installTypeDateJalali,
    bool? isTroubleShooter,
    int? tashimType,
    String? tashimTypeTitle,
    bool? isDeleted,
    bool? isActive,
  }) {
    return VehicleInfoSearchEntity(
      id: id ?? this.id,
      imeiId: imeiId ?? this.imeiId,
      imeiSerial: imeiSerial ?? this.imeiSerial,
      licensePlate: licensePlate ?? this.licensePlate,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      vehicleStatus: vehicleStatus ?? this.vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle ?? this.vehicleStatusTitle,
      productYear: productYear ?? this.productYear,
      vehicleModelId: vehicleModelId ?? this.vehicleModelId,
      vehicleModelTitle: vehicleModelTitle ?? this.vehicleModelTitle,
      vehicleModelName: vehicleModelName ?? this.vehicleModelName,
      navganCode: navganCode ?? this.navganCode,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      installTypeDate: installTypeDate ?? this.installTypeDate,
      installTypeDateJalali: installTypeDateJalali ?? this.installTypeDateJalali,
      isTroubleShooter: isTroubleShooter ?? this.isTroubleShooter,
      tashimType: tashimType ?? this.tashimType,
      tashimTypeTitle: tashimTypeTitle ?? this.tashimTypeTitle,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
    );
  }
}
