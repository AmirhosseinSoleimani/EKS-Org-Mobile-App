import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard({
    super.key,
    required this.item,
    required this.onOperations,
  });

  final ShiftEntity item;
  final VoidCallback onOperations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
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
              CircleAvatar(
                radius: AppSize.s24,
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                child: SvgWidget(src: SvgAsset(SvgManager.swapDriving)),
              ),
              Space.w12,
              Expanded(
                flex: 6,
                child: Text(
                  _value(item.title),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Space.w12,
              StatusLabel(
                text: item.isActive ? 'فعال' : 'غیرفعال',
                color: item.isActive
                    ? theme.colorScheme.onError
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
            ],
          ),
          Space.h16,
          _InfoRow(
            icon: Icons.ac_unit_rounded,
            label: 'نوع',
            value: _value(item.typeTitle),
          ),
          Space.h12,
          _InfoRow(
            icon: Icons.schedule_rounded,
            label: 'زمان شروع',
            value: _dateTimeValue(
              date: item.startDateJalali,
              time: item.startTimeStr ?? item.startTime,
            ),
          ),
          Space.h12,
          _InfoRow(
            icon: Icons.schedule_rounded,
            label: 'زمان پایان',
            value: _dateTimeValue(
              date: item.endDateJalali,
              time: item.endTimeStr ?? item.endTime,
            ),
          ),
          Space.h12,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${_value(item.insertUserFullName)}',
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  color: theme.colorScheme.onPrimaryFixed,
                  fontWeight: FontWeight.w500,
                ),
              ),
              BodySmallText(
                text: JalaliDateHelper.formatStringJalaliDateTime(
                  item.insertDateTimeJalali,
                ),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                color: theme.colorScheme.onPrimaryFixed,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Space.h16,
          InkwellButtonWidget(
            title: 'عملیات',
            backgroundColor: theme.colorScheme.secondaryContainer,
            titleColor: theme.colorScheme.onTertiaryFixed,
            prefixIcon: Icon(
              Icons.settings_outlined,
              color: theme.colorScheme.onTertiaryFixed,
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.onTertiaryFixed,
            ),
            onTap: onOperations,
          ),
        ],
      ),
    );
  }

  String _dateTimeValue({String? date, String? time}) {
    final normalizedDate = _value(date);
    final normalizedTime = _value(time);
    if (normalizedDate == '---') return normalizedTime;
    if (normalizedTime == '---') return normalizedDate;
    return '$normalizedDate، $normalizedTime';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: AppSize.s20, color: theme.colorScheme.onSurfaceVariant),
        Space.w8,
        Text(
          '$label:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
        Space.w4,
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
