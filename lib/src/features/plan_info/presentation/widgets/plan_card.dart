import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final PlanInfoEntity item;
  final VoidCallback onEdit;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final VoidCallback onStatus;
  final VoidCallback onCancelRequests;
  final VoidCallback onLocation;
  final VoidCallback onHistory;

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = item.isActive;
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.primary.withAlpha(25),
                  child: Icon(
                    Icons.person_3_outlined,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                ),

                Space.w12,

                Expanded(
                  child: BodyMediumText(
                    text: item.personsText,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                Space.w8,

                StatusLabel(
                  text: isActive ? 'فعال' : 'غیرفعال',
                  color: isActive ? colorScheme.onError : colorScheme.error,
                ),
              ],
            ),
            Space.h16,
            Padding(
              padding: EdgeInsetsGeometry.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoLine(
                    icon: Icons.engineering_outlined,
                    text: 'واحد امدادی: ${item.emdadUnitName}',
                  ),

                  _InfoLine(
                    icon: Icons.timer_outlined,
                    text: 'شیفت: ${item.shiftTitle}',
                  ),
                  _InfoLine(
                    icon: Icons.bus_alert_outlined,
                    text: item.seatTypeTitle != null
                        ? 'محل استقرار: ${item.seatTypeTitle}'
                        : 'محل استقرار: ---}',
                  ),

                  _InfoLine(
                    icon: Icons.location_on_outlined,
                    text: item.locationTitle != null
                        ? 'آدرس: ${item.locationTitle}'
                        : 'آدرس: ---',
                  ),
                  _InfoLine(
                    icon: Icons.calendar_month_outlined,
                    text: 'بازه: ${item.dateRangeText}',
                  ),
                  BodyMediumText(text: 'توضیحات: ${item.description ?? '---'}'),
                  Divider(color: colorScheme.onInverseSurface),
                  Space.h12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyMediumText(
                        text:
                            item.insertUserFullName != null &&
                                item.insertUserFullName!.trim().isNotEmpty
                            ? 'ثبت کننده: ${item.insertUserFullName}'
                            : 'ثبت کننده: ---',
                        color: colorScheme.onTertiaryFixed,
                        fontSize: 15,
                      ),
                      BodyMediumText(
                        text: formatJalaliDateTime(item.insertDateTimeJalali),
                        color: colorScheme.onTertiaryFixed,
                        fontSize: 15,
                      ),
                    ],
                  ),
                  Space.h8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyMediumText(
                        text:
                            item.updateUserFullName != null &&
                                item.updateUserFullName!.trim().isNotEmpty
                            ? 'آخرین ویرایش: ${item.updateUserFullName}'
                            : 'آخرین ویرایش: ---',
                        color: colorScheme.onTertiaryFixed,
                        fontSize: 15,
                      ),
                      BodyMediumText(
                        text: formatJalaliDateTime(item.updateDateTimeJalali),
                        color: colorScheme.onTertiaryFixed,
                        fontSize: 15,
                      ),
                    ],
                  ),

                  if ((item.reasonTitle ?? item.description) != null) ...[
                    Space.h8,
                    Text(
                      'دلیل تغییر وضعیت: ${item.reasonTitle ?? '---'}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  Space.h8,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkwellButtonWidget(
                      title: 'عملیات',
                      height: AppSize.s42,
                      backgroundColor: colorScheme.secondaryContainer,
                      titleColor: colorScheme.onSurface,
                      prefixIcon: Icon(
                        Icons.settings_outlined,
                        size: AppSize.s20,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      suffixIcon: Icon(
                        Icons.expand_more_outlined,
                        size: AppSize.s20,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onTap: () => _showActionsSheet(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    BottomSheetMessage.showCustom(
        backgroundColor: Colors.white,
        context: context,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _ActionTile(icon: Icons.edit, title: 'ویرایش', onTap: onEdit),
            //  _ActionTile(icon: Icons.copy, title: 'کپی', onTap: onCopy),
            /*  _ActionTile(
                icon: Icons.cancel_outlined,
                title: 'لغو ماموریت',
                onTap: onCancelRequests,
              ),*/
            BottomSheetActionTile(
              icon: Icons.bus_alert_outlined,
              title: 'تغییر محل استقرار',
              onTap: onLocation,
            ),
            Divider(color: colorScheme.onInverseSurface,),
            BottomSheetActionTile(
              icon: Icons.toggle_off_outlined,
              title: 'تغییر وضعیت',
              onTap: onStatus,
            ),
            Divider(color: colorScheme.onInverseSurface,),
            BottomSheetActionTile(
              icon: Icons.history_outlined,
              title: 'تاریخچه',
              onTap: onHistory,
            ),
            Divider(color: colorScheme.onInverseSurface,),
            BottomSheetActionTile(
              icon: Icons.delete_forever_outlined,
              title: 'حذف',
              onTap: onDelete,
              isDestructive: true,
            ),
          ],
        ),
        actionWidget: SizedBox.shrink());

  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppSize.s20,
            color: Theme.of(context).colorScheme.onPrimaryFixed,
          ),
          Space.w8,
          Expanded(
            child: BodyMediumText(
              text: text,
              color: colorScheme.onTertiaryFixed,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
