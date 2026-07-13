import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/emdad_vehicle_info_entity.dart';

class EmdadVehicleInfoModel extends EmdadVehicleInfoEntity {
  const EmdadVehicleInfoModel({
    super.id,
    super.imeiId,
    super.licensePlate,
    super.chassisNumber,
    super.engineNumber,
    super.vehicleStatus,
    super.vehicleStatusTitle,
    super.productYear,
    super.vehicleModelId,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.installTypeDate,
    super.installTypeDateJalali,
    super.isTroubleShooter,
    super.tashimType,
    super.tashimTypeTitle,
    super.isDeleted,
    super.isActive,
    super.isDepotEnabled,
  });

  factory EmdadVehicleInfoModel.fromJson(Map<String, dynamic> json) {
    return EmdadVehicleInfoModel(
      id: json['id'] as int?,
      imeiId: json['imeiid'] as int?,
      licensePlate: json['licensePlate'] as String?,
      chassisNumber: json['chassisNumber'] as String?,
      engineNumber: json['engineNumber'] as String?,
      vehicleStatus: json['vehicleStatus'] as int?,
      vehicleStatusTitle: json['vehicleStatusTitle'] as String?,
      productYear: json['productYear'] as String?,
      vehicleModelId: json['vehicleModelId'] as int?,
      insertDateTime: json['insertDateTime'] as String?,
      insertDateTimeJalali: json['insertDateTimeJalali'] as String?,
      installTypeDate: json['installTypeDate'] as String?,
      installTypeDateJalali: json['installTypeDateJalali'] as String?,
      isTroubleShooter: json['isTroubleShooter'] as bool?,
      tashimType: json['tashimType'] as int?,
      tashimTypeTitle: json['tashimTypeTitle'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      isActive: json['isActive'] as bool?,
      isDepotEnabled: json['isDepotEnabled'] as bool?,
    );
  }

  static List<EmdadVehicleInfoModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => EmdadVehicleInfoModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imeiid': imeiId,
      'licensePlate': licensePlate,
      'chassisNumber': chassisNumber,
      'engineNumber': engineNumber,
      'vehicleStatus': vehicleStatus,
      'vehicleStatusTitle': vehicleStatusTitle,
      'productYear': productYear,
      'vehicleModelId': vehicleModelId,
      'insertDateTime': insertDateTime,
      'insertDateTimeJalali': insertDateTimeJalali,
      'installTypeDate': installTypeDate,
      'installTypeDateJalali': installTypeDateJalali,
      'isTroubleShooter': isTroubleShooter,
      'tashimType': tashimType,
      'tashimTypeTitle': tashimTypeTitle,
      'isDeleted': isDeleted,
      'isActive': isActive,
      'isDepotEnabled': isDepotEnabled,
    };
  }
}
