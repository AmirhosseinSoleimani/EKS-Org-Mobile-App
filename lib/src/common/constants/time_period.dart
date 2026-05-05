import 'package:flutter/material.dart';

import '../../shared/widgets/filter_widgets/interfaces/dropdown_item.dart';

enum TimePeriod implements DropdownItem {
  all('1', 'همه'),
  thisWeek('2', 'هفته اخیر'),
  today('3', 'امروز');

  @override
  final String value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) {
    return null;
  }

  const TimePeriod(this.value, this.label);
}
