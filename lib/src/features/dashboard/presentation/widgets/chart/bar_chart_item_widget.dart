import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class BarChartItemWidget extends StatelessWidget {
  final String title;
  final double percent; // 0 - 100
  final int count;
  final Color color;
  final double barHeight;

  const BarChartItemWidget({
    super.key,
    required this.title,
    required this.percent,
    required this.count,
    required this.color,
    this.barHeight = 34,
  });

  @override
  Widget build(BuildContext context) {
    final value = (percent.clamp(0, 100) / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: BodyMediumText(text: title),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final usableWidth = maxWidth - (maxWidth * 0.1);
            final barWidth = usableWidth * value;

            return Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: barWidth,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerRight,
                    child: BodySmallText(
                      text: "$count",
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: barWidth + 8,
                  top: barHeight / 2 - 8,
                  child: BodyMediumText(
                    text: "${percent.toStringAsFixed(1)}%",
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
