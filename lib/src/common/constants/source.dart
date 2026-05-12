import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

enum Source implements DropdownItem {
  emdadgar(1, 'امداد رسان', 'Emdadresan'),
  customer(2, 'مشتری', 'Customer');

  @override
  final int value;

  @override
  final String label;
  final String sourceTypeName;

  const Source(this.value, this.label, this.sourceTypeName);

  static Source fromValue(int? value) {
    return Source.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Source.emdadgar,
    );
  }

  @override
  Widget? leading(BuildContext context) => null;
}
