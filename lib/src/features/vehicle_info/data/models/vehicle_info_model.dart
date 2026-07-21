import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';

class VehicleInfoModel extends VehicleInfoEntity {
  const VehicleInfoModel({
    super.id,
    super.licensePlate,
    super.imeiSerial,
    super.imeiId,
    super.vehicleModelTitle,
    super.vehicleModelId,
    super.chassisNumber,
    super.engineNumber,
    super.vehicleStatus,
    super.vehicleStatusTitle,
    super.productYear,
    super.installTypeDate,
    super.installTypeDateJalali,
    super.isActive,
    super.isTroubleShooter,
    super.isDeleted,
    super.isDepotEnabled,
    super.navganCode,
    super.tashimType,
    super.tashimTypeTitle,
    super.insertDateTimeJalali,
    super.insertUserFullName,
    super.updateUserFullName,
    super.updateDateTimeJalali,
  });

  factory VehicleInfoModel.fromJson(Map<String, dynamic> json) {
    return VehicleInfoModel(
      id: json['id'] as int?,
      licensePlate: json['licensePlate'] as String?,
      imeiSerial: json['imeiSerial']?.toString() ?? json['imeiid']?.toString(),
      imeiId: json['imeiid'] as int?,
      vehicleModelTitle: json['vehicleModelTitle'] as String?,
      vehicleModelId: json['vehicleModelId'] as int?,
      chassisNumber: json['chassisNumber'] as String?,
      engineNumber: json['engineNumber'] as String?,
      vehicleStatus: json['vehicleStatus'] as int?,
      vehicleStatusTitle: json['vehicleStatusTitle'] as String?,
      productYear: json['productYear']?.toString(),
      installTypeDate: json['installTypeDate']?.toString(),
      installTypeDateJalali: json['installTypeDateJalali'] as String?,
      isActive: json['isActive'] as bool?,
      isTroubleShooter: json['isTroubleShooter'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isDepotEnabled: json['isDepotEnabled'] as bool?,
      navganCode: json['navganCode']?.toString(),
      tashimType: json['tashimType'] as int?,
      tashimTypeTitle: json['tashimTypeTitle'] as String? ?? json['tashimType']?.toString(),
      insertDateTimeJalali: json['insertDateTimeJalali'] as String?,
      insertUserFullName: json['insertUserFullName'] as String?,
      updateUserFullName: json['updateUserFullName'] as String?,
      updateDateTimeJalali: json['updateDateTimeJalali'] as String?,
    );
  }
}
