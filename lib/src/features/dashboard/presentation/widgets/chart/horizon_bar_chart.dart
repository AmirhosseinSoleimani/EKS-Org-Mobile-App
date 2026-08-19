import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/widgets/chart/dashboard_chart_color_resolver.dart';
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
    final colors = DashboardChartColorResolver.resolveSeries(
      context: context,
      items: items,
    );

    return Column(
      children: items
          .asMap()
          .entries
          .map(
            (entry) => BarChartItemWidget(
              title: entry.value.title,
              percent: entry.value.percent,
              count: entry.value.count,
              color: colors[entry.key],
            ),
          )
          .toList(),
    );
  }
}
