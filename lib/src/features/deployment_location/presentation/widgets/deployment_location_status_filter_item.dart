import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class DeploymentLocationStatusFilterItem implements DropdownItem<bool?> {
  const DeploymentLocationStatusFilterItem._(this.value, this.label);

  static const all = DeploymentLocationStatusFilterItem._(null, 'همه');
  static const active = DeploymentLocationStatusFilterItem._(true, 'فعال');
  static const inactive = DeploymentLocationStatusFilterItem._(
    false,
    'غیرفعال',
  );

  static const values = [all, active, inactive];

  @override
  final bool? value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}
