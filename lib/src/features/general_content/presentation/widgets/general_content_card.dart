import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
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

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',
                color: item.isActive == true
                    ? theme.colorScheme.onError
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
              Space.w8,
              if (item.contentTypeText?.trim().isNotEmpty == true)
                StatusLabel(
                  text: item.contentTypeText!,
                  color: theme.colorScheme.outlineVariant,
                  variant: StatusLabelVariant.filledWithoutBorder,
                ),
            ],
          ),
          Space.h12,
          TitleLargeText(
            text: item.title ?? '---',
            color: theme.colorScheme.onSurface,
            fontSize: AppSize.s18,
            textAlign: TextAlign.start,
          ),
          Space.h14,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _DateInfo(
                  icon: Icons.calendar_today_outlined,
                  title: 'تاریخ ابلاغ',
                  value: item.startDateJalali,
                ),
              ),
              Space.w8,
              Flexible(
                child: _DateInfo(
                  icon: Icons.event_available_outlined,
                  title: 'تاریخ اجرا',
                  value: item.applyDateJalali,
                ),
              ),
            ],
          ),
          Space.h12,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${item.insertUserFullName ?? '---'}',
                  color: theme.colorScheme.onTertiaryFixed,
                  fontSize: AppSize.s14,
                  maxLines: 1,
                ),
              ),
              BodySmallText(
                text: JalaliDateHelper.formatStringJalaliDateTime(
                  item.insertDateTimeJalali,
                ),
                color: theme.colorScheme.onTertiaryFixed,
                fontSize: AppSize.s14,
              ),
            ],
          ),
          Space.h14,
          InkwellButtonWidget(
            title: 'عملیات',
            backgroundColor: theme.colorScheme.secondaryContainer,
            titleColor: theme.colorScheme.onTertiaryFixed,
            showLoading: isActionLoading,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onTertiaryFixed,
            ),
            prefixIcon: Icon(
              Icons.settings_outlined,
              color: theme.colorScheme.onTertiaryFixed,
              size: AppSize.s20,
            ),
            onTap: onActions,
          ),
        ],
      ),
    );
  }
}

class _DateInfo extends StatelessWidget {
  const _DateInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onTertiaryFixed;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: AppSize.s16),
        Space.w4,
        Flexible(
          child: BodySmallText(
            text: '$title: ${value ?? '---'}',
            color: color,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
