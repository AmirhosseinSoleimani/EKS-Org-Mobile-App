import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class AgencyInfoSummaryCard extends StatelessWidget {
  const AgencyInfoSummaryCard({
    super.key,
    required this.item,
    this.onTap,
    this.onAction,
    this.trailing,
  });

  final AgencyInfoEntity item;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.06),
              blurRadius: AppSize.s16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(theme),
            Space.h12,
            _InfoRow(
              icon: Icons.badge_outlined,
              label: 'کد نمایندگی',
              value: item.code,
            ),
            _InfoRow(
              icon: Icons.person_outline_rounded,
              label: 'نام مدیر',
              value: item.managerFullName,
            ),
            _InfoRow(
              icon: Icons.contact_mail_outlined,
              label: 'کد ملی مدیر',
              value: item.nationalNumber,
            ),
            _InfoRow(
              icon: Icons.monetization_on_outlined,
              label: 'کد اقتصادی',
              value: item.economicCode,
            ),
            _InfoRow(
              icon: Icons.phone_android_outlined,
              label: 'شماره تماس',
              value: item.mobileNumber ?? item.telephone,
            ),
            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'آدرس',
              value: _join([item.provinceTitle, item.cityTitle, item.address]),
              maxLines: 2,
            ),
            Space.h12,
            Divider(height: AppSize.s1, color: theme.dividerColor.withOpacity(0.55)),
            Space.h12,
            _MetaRow(
              user: item.updateUserFullName ?? item.insertUserFullName,
              date: item.updateDateTimeJalali ?? item.insertDateTimeJalali,
            ),
            if (onAction != null) ...[
              Space.h16,
              InkwellButtonWidget(
                title: 'عملیات',
                height: AppSize.s48,
                backgroundColor: theme.colorScheme.secondaryContainer,
                titleColor: theme.colorScheme.onSurface,
                prefixIcon: Icon(
                  Icons.settings_outlined,
                  size: AppSize.s20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: AppSize.s20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onTap: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: AppSize.s16,
            ),
          ),
        ),
        Space.w8,
        trailing ??
            Wrap(
              spacing: AppSize.s8,
              runSpacing: AppSize.s8,
              children: [
                AgencyInfoStatusBadge(isActive: item.isActive),
                if (item.typeTitle?.trim().isNotEmpty == true)
                  _SoftBadge(title: item.typeTitle!.trim()),
              ],
            ),
      ],
    );
  }

  static String _dash(String? value) {
    return value?.trim().isNotEmpty == true ? value!.trim() : '---';
  }

  static String? _join(List<String?> values) {
    final result = values
        .where((item) => item?.trim().isNotEmpty == true)
        .map((item) => item!.trim())
        .join('، ');
    return result.isEmpty ? null : result;
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFCBE7F5),
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onPrimaryFixed,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String? value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppSize.s20, color: theme.colorScheme.onSurfaceVariant),
          Space.w8,
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onTertiaryFixed,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              AgencyInfoSummaryCard._dash(value),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
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
    required this.user,
    required this.date,
  });

  final String? user;
  final String? date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            'ثبت‌کننده: ${AgencyInfoSummaryCard._dash(user)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Space.w8,
        Text(
          AgencyInfoSummaryCard._dash(date),
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
