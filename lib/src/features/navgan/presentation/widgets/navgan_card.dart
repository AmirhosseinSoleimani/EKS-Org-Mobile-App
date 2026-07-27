import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class NavganCard extends StatelessWidget {
  const NavganCard({
    super.key,
    required this.item,
    required this.onActions,
  });

  final NavganEntity item;
  final VoidCallback onActions;

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
              CircleAvatar(
                radius: AppSize.s28,
                backgroundColor: theme.colorScheme.primary.withAlpha(25),
                child: Icon(
                  Icons.commute,
                  color: theme.colorScheme.primary,
                ),
              ),
              Space.w12,
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  TitleLargeText(
                    text: item.title ?? '---',
                    color: theme.colorScheme.onSurface,
                    fontSize: AppSize.s18,
                    textAlign: TextAlign.start,
                  ),
                  Space.h8,
                  TitleMediumText(
                    text: 'کد ناوگان: ${item.code}',
                    color: theme.colorScheme.onTertiaryFixed,
                    fontSize: AppSize.s14,
                    textAlign: TextAlign.start,
                  )
                ],),
              ),

              const Spacer(),
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',

                color: item.isActive == true
                    ? theme.colorScheme.onError
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
            ],
          ),
          Space.h8,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت کننده: ${item.insertUserFullName ?? '---'}',
                  color: theme.colorScheme.onTertiaryFixed,
                  fontSize: 15,
                ),
              ),
              BodySmallText(
                text: JalaliDateHelper.formatStringJalaliDateTime(item.insertDateTimeJalali),
                color: theme.colorScheme.onTertiaryFixed,
                fontSize: 15,
              ),
            ],
          ),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'آخرین ویرایش: ${item.updateUserFullName ?? '---'}',
                  color: theme.colorScheme.onTertiaryFixed,
                  fontSize: 15,
                ),
              ),
              BodySmallText(
                text: JalaliDateHelper.formatStringJalaliDateTime(item.updateDateTimeJalali),
                color: theme.colorScheme.onTertiaryFixed,
                fontSize: 15,
              ),
            ],
          ),
          Space.h14,

          InkwellButtonWidget(
            title: 'عملیات',
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            titleColor: theme.colorScheme.onTertiaryFixed,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onTertiaryFixed,
            ),
            prefixIcon: Icon(
              Icons.settings_outlined,
              color: theme.colorScheme.onTertiaryFixed,
              size: 19,
            ),
            onTap: onActions,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.onSurfaceVariant, size: AppSize.s20),
        Space.w8,
        BodyMediumText(
          text: '$title: ',
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        Expanded(
          child: BodyMediumText(
            text: value?.trim().isNotEmpty == true ? value! : '---',
            color: colorScheme.onSurfaceVariant,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
