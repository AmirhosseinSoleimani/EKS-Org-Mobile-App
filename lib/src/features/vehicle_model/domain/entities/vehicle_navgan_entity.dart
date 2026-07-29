import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class VehicleNavganEntity implements DropdownItem<int> {
  const VehicleNavganEntity({
    this.id,
    this.emdadgarNavganType,
    this.title,
    this.code,
    this.isActive,
  });

  final int? id;
  final int? emdadgarNavganType;
  final String? title;
  final String? code;
  final bool? isActive;

  @override
  int get value => id ?? 0;

  @override
  String get label => title?.trim().isNotEmpty == true ? title! : '---';

  @override
  Widget? leading(BuildContext context) => null;
}
