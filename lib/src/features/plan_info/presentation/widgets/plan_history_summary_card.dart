import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class PlanHistorySummaryCard extends StatelessWidget {
  const PlanHistorySummaryCard({
    super.key,
    required this.item,
  });

  final PlanInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          _SummaryHeader(title: _headerTitle),
          Space.h12,
          Divider(
            height: AppSize.s1,
            thickness: AppSize.s1,
            color: theme.dividerColor,
          ),
          Space.h8,
          _SummaryRow(
            icon: Icons.calendar_month_outlined,
            text: _shiftAndSeatType,
          ),
          Space.h8,
          _SummaryRow(
            icon: Icons.location_on_outlined,
            text: _locationTitle,
          ),
        ],
      ),
    );
  }

  String get _headerTitle {
    return _firstAvailable([
      item.personsText,
      item.emdadUnitName,
      item.title,
    ]);
  }

  String get _shiftAndSeatType {
    final shift = _normalize(item.shiftTitle);
    final seatType = _normalize(item.seatTypeTitle);

    final formattedShift = shift == null
        ? null
        : shift.contains('شیفت')
        ? shift
        : 'شیفت $shift';

    final values = [
      formattedShift,
      seatType,
    ].whereType<String>().toList();

    return values.isEmpty ? '---' : values.join('، ');
  }

  String get _locationTitle {
    return _firstAvailable([
      item.locationTitle,
      item.address,
    ]);
  }

  String _firstAvailable(List<String?> values) {
    for (final value in values) {
      final normalized = _normalize(value);

      if (normalized != null) {
        return normalized;
      }
    }

    return '---';
  }

  String? _normalize(String? value) {
    final normalized = value?.trim();

    if (normalized == null ||
        normalized.isEmpty ||
        normalized == '---') {
      return null;
    }

    return normalized;
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: AppSize.s48,
          height: AppSize.s48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.primary.withOpacity(0.08),
          ),
          child: Icon(
            Icons.person_outline_rounded,
            size: AppSize.s22,
            color: colorScheme.primary,
          ),
        ),
        Space.w12,
        Expanded(
          child: BodyMediumText(
            text: title,
            color: colorScheme.onSurface,
            fontSize: AppSize.s16,
            fontWeight: FontWeight.w700,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSize.s20,
            color: colorScheme.onSurfaceVariant,
          ),
          Space.w8,
          Expanded(
            child: BodyMediumText(
              text: text,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}