import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class LeaveListCard extends StatelessWidget {
  const LeaveListCard({
    super.key,
    required this.item,
    required this.onDetailsTap,
    required this.onDelete,
  });

  final LeaveListItemEntity item;
  final VoidCallback onDetailsTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AppSummaryCard(
      margin: const EdgeInsets.only(bottom: AppPadding.p16),
      title: item.agencyName?.trim().isNotEmpty == true
          ? item.agencyName!
          : item.planTitle ?? '---',
      badges: [
        LeaveStatusBadge(
          statusCode: item.statusCode,
          title: item.statusText,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.apartment_rounded,
          label: 'کد نمایندگی',
          value: item.agencyCode?.toString(),
        ),
        SummaryCardInfo(
          icon: Icons.person_outline_rounded,
          label: 'امدادرسان',
          value: item.emdadgarFullName,
        ),
        SummaryCardInfo(
          icon: Icons.schedule_rounded,
          label: 'نوع مرخصی',
          value: item.leaveTypeText,
        ),
        SummaryCardInfo(
          icon: Icons.info_outline_rounded,
          label: 'علت اصلی',
          value: item.mainReasonText,
        ),
        SummaryCardInfo(
          icon: Icons.calendar_today_outlined,
          label: 'بازه',
          value: '${_date(item.startDateJalali, item.startTime)} تا '
              '${_date(item.endDateJalali, item.endTime)}',
          textDirection: TextDirection.rtl,
          maxLines: 2,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: item.insertDateTimeJalali,
        ),
      ],
      onOperation: () => _showActionsSheet(context),
      primaryAction: InkwellButtonWidget(
        title: 'مشاهده جزئیات',
        backgroundColor: ColorLightManager.primary,
        titleColor: Colors.white,
        prefixIcon: const Icon(
          Icons.visibility_outlined,
          color: Colors.white,
          size: AppSize.s20,
        ),
        onTap: onDetailsTap,
      ),
    );
  }

  void _showActionsSheet(BuildContext context) {
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Colors.white,
      content: BottomSheetActionTile(
        icon: Icons.delete_forever_outlined,
        title: 'حذف',
        isDestructive: true,
        onTap: () {
          Navigator.of(context).pop();
          onDelete();
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  String _date(String? date, String? time) {
    final safeDate = date?.trim();
    if (safeDate == null || safeDate.isEmpty) return '---';
    if (time == null || time.trim().isEmpty) return safeDate;
    return '$safeDate ${time.trim()}';
  }
}
