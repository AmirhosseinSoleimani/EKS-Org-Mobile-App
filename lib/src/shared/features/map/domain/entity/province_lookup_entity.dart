import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class ProvinceLookupEntity implements DropdownItem<int> {
  const ProvinceLookupEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.code,
    this.type,
    this.isActive = true,
  });

  final int id;
  final int? parentId;
  final String name;
  final int? code;
  final int? type;
  final bool isActive;

  @override
  String get label => name;

  @override
  int get value => id;

  @override
  Widget? leading(BuildContext context) => null;
}
