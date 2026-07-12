import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_info_row.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class LeaveListCard extends StatelessWidget {
  const LeaveListCard({
    super.key,
    required this.item,
    required this.onDetailsTap,
  });

  final LeaveListItemEntity item;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p16),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.agencyName?.trim().isNotEmpty == true
                          ? item.agencyName!
                          : item.planTitle ?? '---',
                      textAlign: TextAlign.right,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.shadow,
                      ),
                    ),
                  ),
                  Space.w12,
                  LeaveStatusBadge(
                    statusCode: item.statusCode,
                    title: item.statusText,
                  ),

                ],
              ),
              Space.h8,
              LeaveInfoRow(
                icon: Icons.apartment_rounded,
                label: 'کد نمایندگی',
                value: item.agencyCode?.toString(),
              ),
              LeaveInfoRow(
                icon: Icons.person_outline_rounded,
                label: 'امدادرسان',
                value: item.emdadgarFullName,
              ),
              LeaveInfoRow(
                icon: Icons.schedule_rounded,
                label: 'نوع مرخصی',
                value: item.leaveTypeText,
              ),
              LeaveInfoRow(
                icon: Icons.info_outline_rounded,
                label: 'علت اصلی',
                value: item.mainReasonText,
              ),
              LeaveInfoRow(
                icon: Icons.calendar_today_outlined,
                label: 'بازه',
                value: '${_date(item.startDateJalali, item.startTime)} تا '
                    '${_date(item.endDateJalali, item.endTime)}',
                ltr: true,
              ),
            ],
          ),
          Space.h12,
          Divider(height: AppSize.s1, thickness: AppSize.s1, color: Theme.of(context).colorScheme.onInverseSurface,),
          Space.h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ثبت‌کننده: ${_text(item.insertUserFullName)}',
                textAlign: TextAlign.right,
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _text(item.insertDateTimeJalali),
                textDirection: TextDirection.rtl,
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF777777),
                ),
              ),
            ],
          ),
          Space.h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 132,
                child: InkwellButtonWidget(
                  title: 'مشاهده جزئیات',
                  height: 40,
                  borderRadius: 7,
                  backgroundColor: ColorLightManager.primary,
                  titleColor: Colors.white,
                  onTap: onDetailsTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _date(String? date, String? time) {
    final safeDate = date?.trim();
    if (safeDate == null || safeDate.isEmpty) return '---';
    if (time == null || time.trim().isEmpty) return safeDate;
    return '$safeDate ${time.trim()}';
  }

  String _text(String? value) {
    return value?.trim().isNotEmpty == true ? value! : '---';
  }
}
