import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class GeneralContentCard extends StatelessWidget {
  const GeneralContentCard({
    super.key,
    required this.item,
    required this.onActions,
    this.isActionLoading = false,
  });

  final GeneralContentEntity item;
  final VoidCallback onActions;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSummaryCard(
      title: item.title ?? '---',
      badgePlacement: SummaryCardBadgePlacement.aboveTitle,
      badges: [
        StatusLabel(
          text: item.isActive == true ? 'فعال' : 'غیرفعال',
          color: item.isActive == true
              ? theme.colorScheme.onError
              : theme.colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
        if (item.contentTypeText?.trim().isNotEmpty == true)
          StatusLabel(
            text: item.contentTypeText!,
            color: theme.colorScheme.outlineVariant,
            variant: StatusLabelVariant.filledWithoutBorder,
          ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.calendar_today_outlined,
          label: 'تاریخ ابلاغ',
          value: item.startDateJalali,
        ),
        SummaryCardInfo(
          icon: Icons.event_available_outlined,
          label: 'تاریخ اجرا',
          value: item.applyDateJalali,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.insertDateTimeJalali,
          ),
        ),
      ],
      onOperation: onActions,
      isOperationLoading: isActionLoading,
    );
  }
}
