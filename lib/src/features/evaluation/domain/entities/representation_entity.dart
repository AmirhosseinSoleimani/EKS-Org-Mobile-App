import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class RepresentationEntity implements DropdownItem<int?> {
  final int? id;
  final int? code;
  final String? title;
  final String? name;

  const RepresentationEntity({
    this.id,
    this.code,
    this.title,
    this.name,
  });

  @override
  String get label => title ?? name ?? code?.toString() ?? '';

  @override
  int? get value => id ?? code;

  @override
  Widget? leading(BuildContext context) => null;
}
