import 'package:eks_sana_plus_org/src/common/utils/extensions/color_code_parser.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:flutter/material.dart';

import 'bar_chart_item_widget.dart';

class HorizonBarChart extends StatelessWidget {
  final List<ChartDataEntity> items;

  const HorizonBarChart({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (element) => BarChartItemWidget(
          title: element.title,
          percent: element.percent,
          count: element.count,
          color: ColorCodeParser.parse(element.color),
        ),
      )
          .toList(),
    );
  }
}
