import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class ImeiStatusFilterItem implements DropdownItem<bool?> {
  const ImeiStatusFilterItem._(this.value, this.label);

  static const all = ImeiStatusFilterItem._(null, 'همه');
  static const active = ImeiStatusFilterItem._(true, 'فعال');
  static const inactive = ImeiStatusFilterItem._(false, 'غیرفعال');

  static const values = [all, active, inactive];

  @override
  final bool? value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}
