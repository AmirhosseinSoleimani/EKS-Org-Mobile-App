import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class PlanHistorySummaryCard extends StatelessWidget {
  const PlanHistorySummaryCard({
    super.key,
    required this.item,
  });

  final PlanInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p14,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            blurRadius: AppSize.s18,
            offset: const Offset(0, AppSize.s8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodySmallText(
            text: 'عنوان برنامه‌ریزی',
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          TitleMediumText(
            text: _dash(item.title),
            color: colorScheme.onSurface,
          ),
          Space.h14,
          Wrap(
            runSpacing: AppSize.s12,
            spacing: AppSize.s24,
            children: [
              _InfoColumn(
                title: 'واحد امدادی',
                value: item.emdadUnitName,
              ),
              _InfoColumn(
                title: 'شیفت',
                value: item.shiftTitle,
              ),
              _InfoColumn(
                title: 'نوع مقر',
                value: item.seatTypeTitle,
              ),
              _InfoColumn(
                title: 'محل استقرار',
                value: item.locationTitle,
              ),
              _InfoColumn(
                title: 'بازه زمانی',
                value: item.dateRangeText,
                ltr: true,
              ),
              _InfoColumn(
                title: 'وضعیت',
                value: item.statusTitle,
              ),
              _InfoColumn(
                title: 'طرح ویژه',
                value: item.specialPlanTitle,
              ),
              _InfoColumn(
                title: 'امدادرسان‌ها',
                value: item.personsText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _dash(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? '---' : text;
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({
    required this.title,
    required this.value,
    this.ltr = false,
  });

  final String title;
  final String? value;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final displayValue = value?.trim().isNotEmpty == true ? value!.trim() : '---';

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: AppSize.s120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodySmallText(
            text: title,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          Space.h4,
          BodyMediumText(
            text: displayValue,
            textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
