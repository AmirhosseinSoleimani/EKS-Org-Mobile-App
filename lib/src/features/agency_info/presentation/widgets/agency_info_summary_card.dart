import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoSummaryCard extends StatelessWidget {
  const AgencyInfoSummaryCard({
    super.key,
    required this.item,
    this.onTap,
    this.trailing,
  });

  final AgencyInfoEntity item;
  final VoidCallback? onTap;
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AgencyIcon(color: theme.colorScheme.primary),
                Space.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Space.h4,
                      Text(
                        _dash(item.code),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing ?? AgencyInfoStatusBadge(isActive: item.isActive),
              ],
            ),
            Space.h12,
            Divider(height: AppSize.s1, color: theme.dividerColor.withOpacity(0.6)),
            Space.h12,
            Row(
              children: [
                Expanded(
                  child: _InfoPill(
                    icon: Icons.person_outline_rounded,
                    value: _dash(item.managerFullName),
                  ),
                ),
                Space.w8,
                Expanded(
                  child: _InfoPill(
                    icon: Icons.location_city_outlined,
                    value: _dash(item.cityTitle ?? item.provinceTitle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _dash(String? value) {
    return value?.trim().isNotEmpty == true ? value!.trim() : '---';
  }
}

class _AgencyIcon extends StatelessWidget {
  const _AgencyIcon({required this.color});

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
      child: Icon(Icons.storefront_outlined, color: color, size: AppSize.s24),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSize.s32,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Row(
        children: [
          Icon(icon, size: AppSize.s16, color: theme.colorScheme.onSurfaceVariant),
          Space.w4,
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
