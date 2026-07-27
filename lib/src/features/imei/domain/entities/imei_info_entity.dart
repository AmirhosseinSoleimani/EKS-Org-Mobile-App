import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_model.dart';

class ImeiInfoEntity {
  const ImeiInfoEntity({
    this.id,
    this.deviceId,
    this.deviceName,
    this.simNumber,
    this.imei,
    this.avlSerial,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.isActive,
  });

  final int? id;
  final int? deviceId;
  final String? deviceName;
  final String? simNumber;
  final String? imei;
  final String? avlSerial;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final bool? isActive;

  ImeiInfoModel toModel() {
    return ImeiInfoModel(
      id: id,
      deviceId: deviceId,
      deviceName: deviceName,
      simNumber: simNumber,
      imei: imei,
      avlSerial: avlSerial,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      isActive: isActive,
    );
  }
}
