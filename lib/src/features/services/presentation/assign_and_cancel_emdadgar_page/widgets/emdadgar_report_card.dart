import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_detail_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class EmdadgarReportCard extends StatelessWidget {
  final String title;
  final EmdadgarReportDetailEntity? detail;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;

  const EmdadgarReportCard({
    super.key,
    required this.title,
    required this.detail,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyMediumText(
            text: title,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 16),

          _ReportRowItem(
            title: "ماموریت",
            value: detail?.successCount ?? 0,
            textColor: titleColor,
          ),

          const SizedBox(height: 8),

          _ReportRowItem(
            title: "لغو غیر مجاز",
            value: detail?.cancelUnSubscribedCount ?? 0,
            textColor: titleColor,
          ),

          const SizedBox(height: 8),

          _ReportRowItem(
            title: "عدم همکاری",
            value: detail?.lackOfCooperationCount ?? 0,
            textColor: titleColor,
          ),
        ],
      ),
    );
  }
}

class _ReportRowItem extends StatelessWidget {
  final String title;
  final int value;
  final Color textColor;

  const _ReportRowItem({
    required this.title,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodySmallText(
          text: title,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        BodySmallText(
          text: value.toString(),
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ],
    );
  }
}
