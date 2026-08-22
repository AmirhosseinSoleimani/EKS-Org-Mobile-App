import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_levels_summary.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_ui_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class GradePatternListCard extends StatelessWidget {
  const GradePatternListCard({
    super.key,
    required this.item,
    required this.onDetails,
    required this.onAction,
    this.isDetailsLoading = false,
    this.isActionLoading = false,
    this.statusLabelText,
    this.statusLabelColor,
    this.showSummary = true,
  });

  final GradePatternUiModel item;
  final VoidCallback onDetails;
  final VoidCallback onAction;
  final bool isDetailsLoading;
  final bool isActionLoading;
  final String? statusLabelText;
  final Color? statusLabelColor;
  final bool showSummary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSummaryCard(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      title: _value(item.title),
      badges: [
        StatusLabel(
          text: statusLabelText ?? (item.isActive ? 'فعال' : 'غیرفعال'),
          color: statusLabelColor ??
              (item.isActive
                  ? theme.colorScheme.onError
                  : theme.colorScheme.error),
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      afterInfo: showSummary
          ? GradePatternLevelsSummary(details: item.details)
          : null,
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.insertDateTimeJalali,
          ),
        ),
      ],
      primaryAction: InkwellButtonWidget(
        title: 'مشاهده جزئیات',
        showLoading: isDetailsLoading,
        onTap: () {
          if (isDetailsLoading) return;
          onDetails();
        },
        prefixIcon: Icon(
          Icons.visibility_outlined,
          color: theme.colorScheme.onPrimary,
          size: AppSize.s22,
        ),
      ),
      onOperation: onAction,
      isOperationLoading: isActionLoading,
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
