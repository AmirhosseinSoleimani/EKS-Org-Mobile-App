import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
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

    return Container(
      margin: const EdgeInsets.only(bottom: AppMargin.m16),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.06),
            blurRadius: AppSize.s18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UnitIcon(color: theme.colorScheme.primary),
              Space.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.agencyInfoName}، ${item.vehicleInfoTitle}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppSize.s14
                      ),
                    ),
                    Space.h6,
                    Text(
                      'کد نمایندگی: ${_value(item.agencyInfoId.toString(), '---')}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Space.w8,
              EmdadUnitStatusBadge(isActive: item.isActive),
            ],
          ),
          Space.h16,
          _InfoRow(
            icon: Icons.person_outline_rounded,
            label: 'امدادرسان',
            value: item.personInfoFullName,
          ),
          _InfoRow(
            icon: Icons.pin_outlined,
            label: 'پلاک خودرو',
            value: item.vehicleInfoTitle,
          ),
          _InfoRow(
            icon: Icons.grading,
            label: 'گرید',
            value: _join([item.gradeTitle, item.gradePatternName]),
          ),
          _InfoRow(
            icon: Icons.star_border_rounded,
            label: 'امتیاز',
            value: item.score?.toString(),
          ),
          _InfoRow(
            icon: Icons.bus_alert,
            label: 'محل استقرار',
            value: item.locationTitle,
          ),
          _InfoRow(
            icon: Icons.pin_drop,
            label: 'آدرس',
            value: item.address,
            maxLines: 3,
          ),
          Space.h12,
          Divider(height: AppSize.s1, color: theme.colorScheme.inverseSurface),
          Space.h12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaRow(
                label: 'ثبت‌کننده',
                value: item.insertUserFullName,
                date: item.insertDateTimeJalali,
              ),
              Space.h8,
              _MetaRow(
                label: 'آخرین ویرایش',
                value: item.updateUserFullName,
                date: item.updateDateTimeJalali,
              ),
            ],
          ),
          Space.h16,
          Align(
            alignment: Alignment.centerLeft,
            child:  InkwellButtonWidget(
              title: 'عملیات',
              height: AppSize.s42,
              backgroundColor: theme.colorScheme.secondaryContainer,
              titleColor: theme.colorScheme.onSurface,
              prefixIcon: Icon(
                Icons.settings_outlined,
                size: AppSize.s20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              suffixIcon: Icon(
                Icons.expand_more_outlined,
                size: AppSize.s20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onTap: onAction,
            ),
          ),
        ],
      ),
    );
  }

  static String _value(String? value, [String fallback = '---']) {
    return value?.trim().isNotEmpty == true ? value!.trim() : fallback;
  }

  static String? _join(List<String?> values) {
    final result = values
        .where((item) => item?.trim().isNotEmpty == true)
        .map((item) => item!.trim())
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 2,
  });

  final IconData icon;
  final String label;
  final String? value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayValue = value?.trim().isNotEmpty == true ? value!.trim() : '---';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppSize.s18, color: theme.colorScheme.onPrimaryFixed),
          Space.w8,
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onTertiaryFixed,
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onTertiaryFixed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.label,
    required this.value,
    required this.date,
  });

  final String label;
  final String? value;
  final String? date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${EmdadUnitCard._value(value)}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Spacer(),
        Text(
          EmdadUnitCard._value(date),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
