import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
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
    print('fgfdgdfgdfgfdg');
    print(item.startDateJalali);
    return AppSummaryCard(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      title: _value(item.title),
      leading: CircleAvatar(
        radius: AppSize.s24,
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
        child: SvgWidget(src: SvgAsset(SvgManager.swapDriving)),
      ),
      badges: [
        StatusLabel(
          text: item.isActive ? 'فعال' : 'غیرفعال',
          color: item.isActive
              ? theme.colorScheme.onError
              : theme.colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.ac_unit_rounded,
          label: 'نوع',
          value: item.typeTitle,
        ),
        SummaryCardInfo(
          icon: Icons.schedule_rounded,
          label: 'زمان شروع',
          value: _dateTimeValue(
            date: item.startDateJalali,
            time: item.startTimeStr ?? item.startTime,
          ),
        ),
        SummaryCardInfo(
          icon: Icons.schedule_rounded,
          label: 'زمان پایان',
          value: _dateTimeValue(
            date: item.endDateJalali,
            time: item.endTimeStr ?? item.endTime,
          ),
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
      onOperation: onOperations,
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

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
