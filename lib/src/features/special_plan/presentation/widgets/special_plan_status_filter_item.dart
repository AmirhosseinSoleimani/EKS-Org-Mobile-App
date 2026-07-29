import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class SpecialPlanStatusFilterItem implements DropdownItem<bool?> {
  const SpecialPlanStatusFilterItem._(this.value, this.label);

  static const all = SpecialPlanStatusFilterItem._(null, 'همه');
  static const active = SpecialPlanStatusFilterItem._(true, 'فعال');
  static const inactive = SpecialPlanStatusFilterItem._(false, 'غیرفعال');

  static const values = [all, active, inactive];

  @override
  final bool? value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}
