import 'package:eks_sana_plus_org/src/features/imei/data/models/device_info_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class DeviceInfoEntity implements DropdownItem<int> {
  const DeviceInfoEntity({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  @override
  int get value => id ?? 0;

  @override
  String get label => name?.trim().isNotEmpty == true ? name! : '---';

  @override
  Widget? leading(BuildContext context) => null;

  DeviceInfoModel toModel() {
    return DeviceInfoModel(
      id: id,
      name: name,
    );
  }
}
