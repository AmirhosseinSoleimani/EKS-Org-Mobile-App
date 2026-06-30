import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';


enum EvaluationIsAcceptedFilter implements DropdownItem {
  accepted('1', 'تایید شده‌ها'),
  all('2', 'همه');

  @override
  final String value;

  @override
  final String label;

  const EvaluationIsAcceptedFilter(this.value, this.label);

  @override
  Widget? leading(BuildContext context) {
    return null;
  }
}
