import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_model.dart';

class VehicleInfoEntity {
  const VehicleInfoEntity({
    this.id,
    this.licensePlate,
    this.imeiSerial,
    this.imeiId,
    this.vehicleModelTitle,
    this.vehicleModelId,
    this.chassisNumber,
    this.engineNumber,
    this.vehicleStatus,
    this.vehicleStatusTitle,
    this.productYear,
    this.installTypeDate,
    this.installTypeDateJalali,
    this.isActive,
    this.isTroubleShooter,
    this.isDeleted,
    this.isDepotEnabled,
    this.navganCode,
    this.tashimType,
    this.tashimTypeTitle,
    this.insertDateTimeJalali,
    this.insertUserFullName,
    this.updateUserFullName,
    this.updateDateTimeJalali,
  });

  final int? id;
  final String? licensePlate;
  final String? imeiSerial;
  final int? imeiId;
  final String? vehicleModelTitle;
  final int? vehicleModelId;
  final String? chassisNumber;
  final String? engineNumber;
  final int? vehicleStatus;
  final String? vehicleStatusTitle;
  final String? productYear;
  final String? installTypeDate;
  final String? installTypeDateJalali;
  final bool? isActive;
  final bool? isTroubleShooter;
  final bool? isDeleted;
  final bool? isDepotEnabled;
  final String? navganCode;
  final int? tashimType;
  final String? tashimTypeTitle;
  final String? insertDateTimeJalali;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? updateDateTimeJalali;

  String get title {
    final modelTitle = vehicleModelTitle?.trim();
    if (modelTitle != null && modelTitle.isNotEmpty) {
      return modelTitle;
    }
    return licensePlate?.trim().isNotEmpty == true ? licensePlate!.trim() : '---';
  }

  VehicleInfoModel toModel() {
    return VehicleInfoModel(
      id: id,
      licensePlate: licensePlate,
      imeiSerial: imeiSerial,
      imeiId: imeiId,
      vehicleModelTitle: vehicleModelTitle,
      vehicleModelId: vehicleModelId,
      chassisNumber: chassisNumber,
      engineNumber: engineNumber,
      vehicleStatus: vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle,
      productYear: productYear,
      installTypeDate: installTypeDate,
      installTypeDateJalali: installTypeDateJalali,
      isActive: isActive,
      isTroubleShooter: isTroubleShooter,
      isDeleted: isDeleted,
      isDepotEnabled: isDepotEnabled,
      navganCode: navganCode,
      tashimType: tashimType,
      tashimTypeTitle: tashimTypeTitle,
      insertDateTimeJalali: insertDateTimeJalali,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      updateDateTimeJalali: updateDateTimeJalali,
    );
  }
}
