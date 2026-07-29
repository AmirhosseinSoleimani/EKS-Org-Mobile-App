import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class VehicleModelStatusFilterItem implements DropdownItem<bool?> {
  const VehicleModelStatusFilterItem._(this.value, this.label);

  static const all = VehicleModelStatusFilterItem._(null, 'همه');
  static const active = VehicleModelStatusFilterItem._(true, 'فعال');
  static const inactive = VehicleModelStatusFilterItem._(false, 'غیرفعال');

  static const values = [all, active, inactive];

  @override
  final bool? value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}
