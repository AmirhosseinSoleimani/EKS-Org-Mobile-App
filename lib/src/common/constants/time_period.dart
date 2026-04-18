import 'package:flutter/material.dart';

import '../../shared/widgets/filter_widgets/interfaces/dropdown_item.dart';

enum TimePeriod implements DropdownItem {
  all('all', 'همه'),
  today('today', 'امروز'),
  thisWeek('thisWeek', 'هفته اخیر');

  final String value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) {
    return null;
  }

  const TimePeriod(this.value, this.label);
}
