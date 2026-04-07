import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:flutter/material.dart';

class IndicatorReportData extends StatelessWidget {
  final IndicatorReportEntity? indicatorReport;

  const IndicatorReportData({
    super.key,
    required this.indicatorReport,
  });

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const SizedBox();
      },
    );
  }
}
