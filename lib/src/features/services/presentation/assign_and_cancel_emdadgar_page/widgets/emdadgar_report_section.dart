import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/emdadgar_report_card.dart';
import 'package:flutter/material.dart';

class EmdadgarReportSection extends StatelessWidget {
  final EmdadgarReportEntity? report;

  const EmdadgarReportSection({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final daily = report?.daily;
    final weekly = report?.weekly;

    return Row(
      children: [
        Expanded(
          child: EmdadgarReportCard(
            title: "امروز",
            detail: daily,
            backgroundColor: Color(0xFF00966d).withAlpha(25),
            borderColor: Color(0xFF00966d),
            titleColor:  Color(0xFF00966d),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: EmdadgarReportCard(
            title: "هفته اخیر",
            detail: weekly,
            backgroundColor: Color(0xFF59168b).withAlpha(25),
            borderColor: Color(0xFF59168b),
            titleColor: Color(0xFF59168b),
          ),
        ),
      ],
    );
  }
}
