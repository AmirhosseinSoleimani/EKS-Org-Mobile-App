import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/filter_widgets/interfaces/dropdown_item.dart' show DropdownItem;

enum EvaluationIsAcceptedFilter implements DropdownItem {
  accepted('1', 'تایید شده‌ها'),
  all('2', 'همه');

  final String value;

  @override
  final String label;

  const EvaluationIsAcceptedFilter(this.value, this.label);

  @override
  Widget? leading(BuildContext context) {
    return null;
  }
}
