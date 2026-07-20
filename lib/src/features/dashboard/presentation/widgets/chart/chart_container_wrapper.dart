import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class ChartContainerWrapper extends StatelessWidget {
  final String title;
  final int totalCount;
  final Widget chart;

  const ChartContainerWrapper({
    super.key,
    required this.title,
    required this.totalCount,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: BodyMediumText(text:
                  title,
                  fontSize: 13,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: BodySmallText(text:
                  "تعداد کل: $totalCount",
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          (totalCount == 0) ? const Center(child: EmptyListWidget()) : chart,
        ],
      ),
    );
  }
}
