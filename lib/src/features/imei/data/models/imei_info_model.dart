import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';

class ImeiInfoModel extends ImeiInfoEntity {
  const ImeiInfoModel({
    super.id,
    super.deviceId,
    super.deviceName,
    super.simNumber,
    super.imei,
    super.avlSerial,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.isActive,
  });

  factory ImeiInfoModel.fromJson(Map<String, dynamic> json) {
    return ImeiInfoModel(
      id: ImeiJsonHelper.integer(json['id']),
      deviceId: ImeiJsonHelper.integer(json['deviceId']),
      deviceName: ImeiJsonHelper.string(json['deviceName']),
      simNumber: ImeiJsonHelper.string(json['simNumber'] ?? json['SIMNumber']),
      imei: ImeiJsonHelper.string(json['imei'] ?? json['IMEI']),
      avlSerial: ImeiJsonHelper.string(json['avlSerial']),
      insertUserFullName: ImeiJsonHelper.string(json['insertUserFullName']),
      updateUserFullName: ImeiJsonHelper.string(json['updateUserFullName']),
      insertDateTime: ImeiJsonHelper.string(json['insertDateTime']),
      insertDateTimeJalali: ImeiJsonHelper.string(json['insertDateTimeJalali']),
      isActive: ImeiJsonHelper.boolean(json['isActive']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceId': deviceId,
      'deviceName': deviceName,
      'simNumber': simNumber,
      'imei': imei,
      'avlSerial': avlSerial,
      'insertUserFullName': insertUserFullName,
      'updateUserFullName': updateUserFullName,
      'insertDateTime': insertDateTime,
      'insertDateTimeJalali': insertDateTimeJalali,
      'isActive': isActive,
    };
  }
}
