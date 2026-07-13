import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class GradePatternCard extends StatelessWidget {
  const GradePatternCard({
    super.key,
    required this.item,
    required this.onDetails,
    required this.onEdit,
    required this.onDelete,
  });

  final GradePatternEntity item;
  final VoidCallback onDetails;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: AppSize.s16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _value(item.name),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Space.w8,
              GradePatternStatusBadge(isActive: item.isActive),
            ],
          ),
          Space.h8,
          Text(
            'کد: ${item.code ?? '---'}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Space.h12,
          Text(
            '${item.details.length} ردیف گرید',
            style: theme.textTheme.bodySmall,
          ),
          Space.h12,
          Row(
            children: [
              _ActionIcon(
                icon: Icons.delete_outline_rounded,
                color: theme.colorScheme.error,
                onTap: onDelete,
              ),
              Space.w8,
              _ActionIcon(
                icon: Icons.edit_outlined,
                color: theme.colorScheme.secondary,
                onTap: onEdit,
              ),
              Space.w8,
              _ActionIcon(
                icon: Icons.visibility_outlined,
                color: theme.colorScheme.primary,
                onTap: onDetails,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s20),
      child: Container(
        width: AppSize.s40,
        height: AppSize.s40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: AppSize.s20),
      ),
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
