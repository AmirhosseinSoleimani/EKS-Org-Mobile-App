import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_date_formatter.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_info_row.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
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
    final registrar = item.insertUserFullName?.trim();
    final insertDate = item.insertDateTimeJalali?.trim();

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TitleMediumText(
                  text: item.title?.trim().isNotEmpty == true
                      ? item.title!.trim()
                      : '---',
                  fontWeight: FontWeight.w800,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              Space.w8,
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',
                color: item.isActive == true
                    ? theme.colorScheme.onError
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
            ],
          ),
          Space.h16,
          SpecialPlanInfoRow(
            icon: Icons.inventory_2_outlined,
            label: 'محصول',
            value: productTitle,
          ),
          Space.h8,
          SpecialPlanInfoRow(
            icon: Icons.map_outlined,
            label: 'محدوده جغرافیایی',
            value: item.displayAreaTitle,
            maxLines: 2,
          ),
          Space.h8,
          SpecialPlanInfoRow(
            icon: Icons.event_available_outlined,
            label: 'تاریخ شروع',
            value: SpecialPlanDateFormatter.jalaliDate(item.startDate),
          ),
          Space.h8,
          SpecialPlanInfoRow(
            icon: Icons.event_busy_outlined,
            label: 'تاریخ پایان',
            value: SpecialPlanDateFormatter.jalaliDate(item.endDate),
          ),
          Space.h8,
          SpecialPlanInfoRow(
            icon: Icons.format_list_numbered_rtl,
            label: 'شماره اولویت',
            value: item.orderNo?.toString() ?? '---',
          ),
          Space.h8,
          SpecialPlanInfoRow(
            icon: Icons.priority_high_rounded,
            label: 'اولویت بالا',
            value: item.hasHighPriority == true ? 'بله' : 'خیر',
          ),
          Space.h8,
          SpecialPlanInfoRow(
            icon: Icons.directions_car_outlined,
            label: 'فقط خودروهای سایپایی',
            value: item.onlySaipaCars == true ? 'بله' : 'خیر',
          ),
          Space.h16,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${registrar?.isNotEmpty == true ? registrar : '---'}',
                  color: theme.colorScheme.onSurfaceVariant,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              Space.w8,
              BodySmallText(
                text: insertDate?.isNotEmpty == true
                    ? JalaliDateHelper.formatStringJalaliDateTime(insertDate)
                    : SpecialPlanDateFormatter.jalaliDateTime(
                        item.insertDateTime,
                      ),
                color: theme.colorScheme.onSurfaceVariant,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
          Space.h12,
          InkwellButtonWidget(
            title: 'عملیات',
            height: AppSize.s42,
            backgroundColor:theme. colorScheme.secondaryContainer,
            titleColor: theme. colorScheme.onSurface,
            prefixIcon: Icon(
              Icons.settings_outlined,
              size: AppSize.s20,
              color: theme. colorScheme.onSurfaceVariant,
            ),
            suffixIcon: Icon(
              Icons.expand_more_outlined,
              size: AppSize.s20,
              color: theme. colorScheme.onSurfaceVariant,
            ),
              onTap: () {
                if (isActionLoading) return;
                onActions();
              },
          ),
        ],
      ),
    );
  }
}
