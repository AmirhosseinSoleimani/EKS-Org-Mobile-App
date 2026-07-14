import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadUnitSummaryCard extends StatelessWidget {
  const EmdadUnitSummaryCard({
    super.key,
    required this.item,
  });

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
                    Space.h4,
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: AppSize.s16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        Space.w4,
                        Expanded(
                          child: Text(
                            _dash(item.personInfoFullName),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Space.h14,
          Divider(height: AppSize.s1, color: Color(0xFFE9E8E7)),
          Space.h12,
          Row(
            children: [
              Expanded(
                child: _InfoPill(
                  icon: Icons.pin_outlined,
                  value: _dash(item.vehicleInfoTitle),
                ),
              ),
              Space.w8,
              Expanded(
                child: _InfoPill(
                  icon: Icons.location_on_outlined,
                  value: _dash(item.locationTitle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _dash(String? value) {
    return value?.trim().isNotEmpty == true ? value!.trim() : '---';
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
      child: Icon(
        Icons.business_outlined,
        color: color,
        size: AppSize.s24,
      ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF5F3F3),
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
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
