import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_date_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class SpecialPlanCard extends StatelessWidget {
  const SpecialPlanCard({
    super.key,
    required this.item,
    required this.productTitle,
    required this.onActions,
    this.isActionLoading = false,
  });

  final SpecialPlanEntity item;
  final String productTitle;
  final VoidCallback onActions;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final insertDate = item.insertDateTimeJalali?.trim();

    return AppSummaryCard(
      title: item.title ?? '---',
      badges: [
        StatusLabel(
          text: item.isActive == true ? 'فعال' : 'غیرفعال',
          color: item.isActive == true
              ? theme.colorScheme.onError
              : theme.colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.inventory_2_outlined,
          label: 'محصول',
          value: productTitle,
        ),
        SummaryCardInfo(
          icon: Icons.map_outlined,
          label: 'محدوده جغرافیایی',
          value: item.displayAreaTitle,
          maxLines: 2,
        ),
        SummaryCardInfo(
          icon: Icons.event_available_outlined,
          label: 'تاریخ شروع',
          value: SpecialPlanDateFormatter.jalaliDate(item.startDate),
        ),
        SummaryCardInfo(
          icon: Icons.event_busy_outlined,
          label: 'تاریخ پایان',
          value: SpecialPlanDateFormatter.jalaliDate(item.endDate),
        ),
        SummaryCardInfo(
          icon: Icons.format_list_numbered_rtl,
          label: 'شماره اولویت',
          value: item.orderNo?.toString(),
        ),
        SummaryCardInfo(
          icon: Icons.priority_high_rounded,
          label: 'اولویت بالا',
          value: item.hasHighPriority == true ? 'بله' : 'خیر',
        ),
        SummaryCardInfo(
          icon: Icons.directions_car_outlined,
          label: 'فقط خودروهای سایپایی',
          value: item.onlySaipaCars == true ? 'بله' : 'خیر',
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: insertDate?.isNotEmpty == true
              ? JalaliDateHelper.formatStringJalaliDateTime(insertDate)
              : SpecialPlanDateFormatter.jalaliDateTime(item.insertDateTime),
          dateTextDirection: TextDirection.ltr,
        ),
      ],
      onOperation: onActions,
      isOperationLoading: isActionLoading,
    );
  }
}
