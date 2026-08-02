import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class EmdadUnitCard extends StatelessWidget {
  const EmdadUnitCard({
    super.key,
    required this.item,
    required this.onAction,
  });

  final EmdadUnitEntity item;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return AppSummaryCard(
      margin: const EdgeInsets.only(bottom: AppMargin.m16),
      title: _join([item.agencyInfoName, item.vehicleInfoTitle]) ?? '---',
      subtitle: 'کد نمایندگی: ${_value(item.agencyInfoId?.toString())}',
      leading: _UnitIcon(color: theme.colorScheme.primary),
      badges: [ StatusLabel(text: (item.isActive ?? false) ? 'فعال' : 'غیرفعال',
          color: (item.isActive ?? false)
              ? colorScheme.onError
              : colorScheme.error)
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.person_outline_rounded,
          label: 'امدادرسان',
          value: item.personInfoFullName,
        ),
        SummaryCardInfo(
          icon: Icons.pin_outlined,
          label: 'پلاک خودرو',
          value: item.vehicleInfoTitle,
        ),
        SummaryCardInfo(
          icon: Icons.grading,
          label: 'گرید',
          value: _join([item.gradeTitle, item.gradePatternName]),
        ),
        SummaryCardInfo(
          icon: Icons.star_border_rounded,
          label: 'امتیاز',
          value: item.score?.toString(),
        ),
        SummaryCardInfo(
          icon: Icons.bus_alert,
          label: 'محل استقرار',
          value: item.locationTitle,
        ),
        SummaryCardInfo(
          icon: Icons.pin_drop,
          label: 'آدرس',
          value: item.address,
          maxLines: 3,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: item.insertDateTimeJalali,
        ),
        SummaryCardMeta(
          label: 'آخرین ویرایش',
          value: item.updateUserFullName,
          date: item.updateDateTimeJalali,
        ),
      ],
      onOperation: onAction,
    );
  }

  static String _value(String? value) {
    return value
        ?.trim()
        .isNotEmpty == true ? value!.trim() : '---';
  }

  static String? _join(List<String?> values) {
    final result = values
        .where((value) =>
    value
        ?.trim()
        .isNotEmpty == true)
        .map((value) => value!.trim())
        .join('، ');
    return result.isEmpty ? null : result;
  }
}

class _UnitIcon extends StatelessWidget {
  const _UnitIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s48,
      height: AppSize.s48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.business_outlined, color: color),
    );
  }
}
