import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';

class VehicleInfoSearchModel extends VehicleInfoSearchEntity {
  const VehicleInfoSearchModel({
    super.id,
    super.imeiId,
    super.imeiSerial,
    super.licensePlate,
    super.chassisNumber,
    super.engineNumber,
    super.vehicleStatus,
    super.vehicleStatusTitle,
    super.productYear,
    super.vehicleModelId,
    super.vehicleModelTitle,
    super.vehicleModelName,
    super.navganCode,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.installTypeDate,
    super.installTypeDateJalali,
    super.isTroubleShooter,
    super.tashimType,
    super.tashimTypeTitle,
    super.isDeleted,
    super.isActive,
  });

  factory VehicleInfoSearchModel.fromJson(Map<String, dynamic> json) {
    return VehicleInfoSearchModel(
      id: AgencyInfoJsonHelper.integer(json['id']),
      imeiId: AgencyInfoJsonHelper.integer(json['imeiid']),
      imeiSerial: AgencyInfoJsonHelper.string(json['imeiSerial']),
      licensePlate: AgencyInfoJsonHelper.string(json['licensePlate']),
      chassisNumber: AgencyInfoJsonHelper.string(json['chassisNumber']),
      engineNumber: AgencyInfoJsonHelper.string(json['engineNumber']),
      vehicleStatus: AgencyInfoJsonHelper.integer(json['vehicleStatus']),
      vehicleStatusTitle: AgencyInfoJsonHelper.string(json['vehicleStatusTitle']),
      productYear: AgencyInfoJsonHelper.string(json['productYear']),
      vehicleModelId: AgencyInfoJsonHelper.integer(json['vehicleModelId']),
      vehicleModelTitle: AgencyInfoJsonHelper.string(json['vehicleModelTitle']),
      vehicleModelName: AgencyInfoJsonHelper.string(json['vehicleModelName']),
      navganCode: AgencyInfoJsonHelper.string(json['navganCode']),
      insertUserFullName: AgencyInfoJsonHelper.string(json['insertUserFullName']),
      updateUserFullName: AgencyInfoJsonHelper.string(json['updateUserFullName']),
      insertDateTime: AgencyInfoJsonHelper.string(json['insertDateTime']),
      insertDateTimeJalali: AgencyInfoJsonHelper.string(json['insertDateTimeJalali']),
      installTypeDate: AgencyInfoJsonHelper.string(json['installTypeDate']),
      installTypeDateJalali: AgencyInfoJsonHelper.string(json['installTypeDateJalali']),
      isTroubleShooter: AgencyInfoJsonHelper.boolean(json['isTroubleShooter']),
      tashimType: AgencyInfoJsonHelper.integer(json['tashimType']),
      tashimTypeTitle: AgencyInfoJsonHelper.string(json['tashimTypeTitle']),
      isDeleted: AgencyInfoJsonHelper.boolean(json['isDeleted']),
      isActive: AgencyInfoJsonHelper.boolean(json['isActive']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imeiid': imeiId,
      'imeiSerial': imeiSerial,
      'licensePlate': licensePlate,
      'chassisNumber': chassisNumber,
      'engineNumber': engineNumber,
      'vehicleStatus': vehicleStatus,
      'vehicleStatusTitle': vehicleStatusTitle,
      'productYear': productYear,
      'vehicleModelId': vehicleModelId,
      'vehicleModelTitle': vehicleModelTitle,
      'vehicleModelName': vehicleModelName,
      'navganCode': navganCode,
      'insertUserFullName': insertUserFullName,
      'updateUserFullName': updateUserFullName,
      'insertDateTime': insertDateTime,
      'insertDateTimeJalali': insertDateTimeJalali,
      'installTypeDate': installTypeDate,
      'installTypeDateJalali': installTypeDateJalali,
      'isTroubleShooter': isTroubleShooter,
      'tashimType': tashimType,
      'tashimTypeTitle': tashimTypeTitle,
      'isDeleted': isDeleted,
      'isActive': isActive,
    };
  }
}
