import 'package:eks_sana_plus_org/src/common/utils/extensions/color_code_parser.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final List<ChartDataEntity> items;
  final double chartRadius;

  const PieChartWidget({
    super.key,
    required this.items,
    this.chartRadius = 110,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: chartRadius * 2,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 0,
              sections: items.map((element) {
                final pct = element.percent.clamp(0, 100);
                return PieChartSectionData(
                  color: ColorCodeParser.parse(element.color),
                  value: element.percent,
                  radius: chartRadius,
                  title: "${pct.toStringAsFixed(1)}%",
                  titleStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  titlePositionPercentageOffset: 0.7,
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Column(
          children: items.map((element) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: ColorCodeParser.parse(element.color),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      const SizedBox(width: 6),
                      BodyMediumText(text: element.title)
                    ],
                  ),
                  BodyMediumText(text: '${element.percent}%'  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
