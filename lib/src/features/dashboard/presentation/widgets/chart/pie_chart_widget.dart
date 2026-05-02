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
        // --- Pie Chart ---
        SizedBox(
          height: chartRadius * 2,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 0,
              sections: items.map((element) {
                final pct = element.percent.clamp(0, 100);
                return PieChartSectionData(
                  color: _parseColor(element.color),
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

        // --- Legend ---
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
                          color: _parseColor(element.color),
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

  Color _parseColor(String? hex) {
    print(hex);
    const fallback = Color(0xFF9E9E9E);

    if (hex == null || hex.isEmpty) return fallback;

    try {
      final cleaned = hex.replaceAll('#', '');

      if (cleaned.length == 6) {
        return Color(int.parse('0xFF$cleaned'));
      } else if (cleaned.length == 8) {
        return Color(int.parse('0x$cleaned'));
      }

      return fallback;
    } catch (_) {
      return fallback;
    }
  }
}
