import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/colored_info_card.dart';
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
          child: ColoredInfoCard(
            title: 'امروز',
            backgroundColor: Color(0xFF00966d).withAlpha(25),
            borderColor: Color(0xFF00966d),
            titleColor:  Color(0xFF00966d),
            items: [
              ColoredInfoCardItem.row(
                title: 'ماموریت',

                value: '${daily?.successCount ?? 0}',
              ),
              ColoredInfoCardItem.row(
                title: 'لغو غیر مجاز',
                value: '${daily?.cancelUnSubscribedCount ?? 0}',
              ),
              ColoredInfoCardItem.row(
                title: 'عدم همکاری',
                value: '${daily?.lackOfCooperationCount ?? 0}',
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),
        Expanded(
          child: ColoredInfoCard(
            title: "هفته اخیر",
            backgroundColor: Color(0xFF59168b).withAlpha(25),
            borderColor: Color(0xFF59168b),
            titleColor: Color(0xFF59168b),
            items: [
              ColoredInfoCardItem.row(
                title: 'ماموریت',

                value: '${weekly?.successCount ?? 0}',
              ),
              ColoredInfoCardItem.row(
                title: 'لغو غیر مجاز',
                value: '${weekly?.cancelUnSubscribedCount ?? 0}',
              ),
              ColoredInfoCardItem.row(
                title: 'عدم همکاری',
                value: '${weekly?.lackOfCooperationCount ?? 0}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
