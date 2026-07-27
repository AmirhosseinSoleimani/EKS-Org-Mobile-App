import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';

class DeviceInfoModel extends DeviceInfoEntity {
  const DeviceInfoModel({
    super.id,
    super.name,
  });

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    return DeviceInfoModel(
      id: ImeiJsonHelper.integer(json['id']),
      name: ImeiJsonHelper.string(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
