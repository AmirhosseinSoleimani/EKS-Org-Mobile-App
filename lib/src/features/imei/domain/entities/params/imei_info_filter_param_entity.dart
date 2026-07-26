import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_filter_request_model.dart';

class ImeiInfoFilterParamEntity {
  const ImeiInfoFilterParamEntity({
    this.simNumber,
    this.avlSerial,
    this.deviceId,
    this.imei,
    this.isActive,
    this.pageSize = 10,
    this.skip = 0,
  });

  final String? simNumber;
  final String? avlSerial;
  final int? deviceId;
  final String? imei;
  final bool? isActive;
  final int pageSize;
  final int skip;

  ImeiInfoFilterRequestModel toModel() {
    return ImeiInfoFilterRequestModel(
      simNumber: simNumber,
      avlSerial: avlSerial,
      deviceId: deviceId,
      imei: imei,
      isActive: isActive,
      pageSize: pageSize,
      skip: skip,
    );
  }

  ImeiInfoFilterParamEntity copyWith({
    String? simNumber,
    String? avlSerial,
    int? deviceId,
    String? imei,
    bool? isActive,
    int? pageSize,
    int? skip,
    bool clearSimNumber = false,
    bool clearAvlSerial = false,
    bool clearDeviceId = false,
    bool clearImei = false,
    bool clearIsActive = false,
  }) {
    return ImeiInfoFilterParamEntity(
      simNumber: clearSimNumber ? null : simNumber ?? this.simNumber,
      avlSerial: clearAvlSerial ? null : avlSerial ?? this.avlSerial,
      deviceId: clearDeviceId ? null : deviceId ?? this.deviceId,
      imei: clearImei ? null : imei ?? this.imei,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      pageSize: pageSize ?? this.pageSize,
      skip: skip ?? this.skip,
    );
  }
}
