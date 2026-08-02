import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onCopy,
    required this.onDelete,
    required this.onStatus,
    required this.onCancelRequests,
    required this.onLocation,
    required this.onHistory,
  });

  final PlanInfoEntity item;
  final VoidCallback onEdit;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final VoidCallback onStatus;
  final VoidCallback onCancelRequests;
  final VoidCallback onLocation;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppSummaryCard(
      title: item.personsText,
      leading: CircleAvatar(
        radius: AppSize.s24,
        backgroundColor: colorScheme.primary.withAlpha(25),
        child: Icon(
          Icons.person_3_outlined,
          color: colorScheme.primary,
          size: AppSize.s24,
        ),
      ),
      badges: [
        StatusLabel(
          text: item.isActive ? 'فعال' : 'غیرفعال',
          color: item.isActive ? colorScheme.onError : colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.engineering_outlined,
          label: 'واحد امدادی',
          value: item.emdadUnitName,
        ),
        SummaryCardInfo(
          icon: Icons.timer_outlined,
          label: 'شیفت',
          value: item.shiftTitle,
        ),
        SummaryCardInfo(
          icon: Icons.bus_alert_outlined,
          label: 'محل استقرار',
          value: item.seatTypeTitle,
        ),
        SummaryCardInfo(
          icon: Icons.location_on_outlined,
          label: 'آدرس',
          value: item.locationTitle,
          maxLines: 2,
        ),
        SummaryCardInfo(
          icon: Icons.calendar_month_outlined,
          label: 'بازه',
          value: item.dateRangeText,
          maxLines: 2,
        ),
        SummaryCardInfo(
          icon: Icons.notes_outlined,
          label: 'توضیحات',
          value: item.description,
          maxLines: 3,
        ),
        if (item.reasonTitle?.trim().isNotEmpty == true)
          SummaryCardInfo(
            icon: Icons.change_circle_outlined,
            label: 'دلیل تغییر وضعیت',
            value: item.reasonTitle,
            maxLines: 2,
          ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: formatJalaliDateTime(item.insertDateTimeJalali),
        ),
        SummaryCardMeta(
          label: 'آخرین ویرایش',
          value: item.updateUserFullName,
          date: formatJalaliDateTime(item.updateDateTimeJalali),
        ),
      ],
      onOperation: () => _showActionsSheet(context),
    );
  }

  String formatJalaliDateTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '---';
    }

    final originalValue = value.trim();

    try {
      final match = RegExp(
        r'^(\d{4}/\d{2}/\d{2})\s+(\d{2}:\d{2})',
      ).firstMatch(originalValue);

      if (match == null) {
        return originalValue;
      }

      final date = match.group(1);
      final time = match.group(2);

      if (date == null || time == null) {
        return originalValue;
      }

      return _toPersianDigits('$time - $date');
    } catch (_) {
      return originalValue;
    }
  }

  String _toPersianDigits(String value) {
    const englishDigits = '0123456789';
    const persianDigits = '۰۱۲۳۴۵۶۷۸۹';

    return value.split('').map((character) {
      final index = englishDigits.indexOf(character);
      return index == -1 ? character : persianDigits[index];
    }).join();
  }

  void _showActionsSheet(BuildContext context) {
    final theme = Theme.of(context);

    BottomSheetMessage.showCustom(
      backgroundColor: Colors.white,
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetActionTile(
            icon: Icons.edit,
            title: 'ویرایش',
            onTap: () {
              context.pop();
              onEdit();
            },
          ),
          Divider(color: theme.dividerColor),
          BottomSheetActionTile(
            icon: Icons.copy,
            title: 'کپی',
            onTap: () {
              context.pop();
              onCopy();
            },
          ),
          Divider(color: theme.dividerColor),
          BottomSheetActionTile(
            icon: Icons.cancel_outlined,
            title: 'لغو ماموریت',
            onTap: () {
              context.pop();
              onCancelRequests();
            },
          ),
          Divider(color: theme.dividerColor),
          BottomSheetActionTile(
            icon: Icons.bus_alert_outlined,
            title: 'تغییر محل استقرار',
            onTap: () {
              context.pop();
              onLocation();
            },
          ),
          Divider(color: theme.dividerColor),
          BottomSheetActionTile(
            icon: Icons.toggle_off_outlined,
            title: 'تغییر وضعیت',
            onTap: () {
              context.pop();
              onStatus();
            },
          ),
          Divider(color: theme.dividerColor),
          BottomSheetActionTile(
            icon: Icons.history_outlined,
            title: 'تاریخچه',
            onTap: () {
              context.pop();
              onHistory();
            },
          ),
          Divider(color: theme.dividerColor),
          BottomSheetActionTile(
            icon: Icons.delete_forever_outlined,
            title: 'حذف',
            isDestructive: true,
            onTap: () {
              context.pop();
              onDelete();
            },
          ),
        ],
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}
