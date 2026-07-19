import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BodyMediumText(
                      text: 'کد: ${item.code ?? '---'}',
                    ),
                    Space.w4,
                    BodyMediumText(
                      text: '•',
                      color: Color(0xFFDEC1AF),
                    ),
                    Space.w4,
                    Expanded(
                      child: BodyMediumText(
                        text: 'عنوان: ${_value(item.name)}',
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Space.h8,
                Row(
                  children: [
                    GradePatternStatusBadge(isActive: item.isActive),
                    Space.w8,
                    Expanded(
                      child: BodyMediumText(
                        text: '${item.details.length} ردیف گرید',
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Space.w12,
          _ActionIcon(
            icon: Icons.visibility_outlined,
            foreground: const Color(0xFF964900),
            background: const Color(0xFF964900).withAlpha(25),
            onTap: onDetails,
          ),
          Space.w8,
          _ActionIcon(
            icon: Icons.edit_outlined,
            foreground: theme.colorScheme.secondary,
            background: theme.colorScheme.secondary.withOpacity(0.10),
            onTap: onEdit,
          ),
          Space.w8,
          _ActionIcon(
            icon: Icons.delete_outline_rounded,
            foreground: theme.colorScheme.error,
            background: theme.colorScheme.error.withOpacity(0.10),
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.foreground,
    required this.background,
    required this.onTap,
  });

  final IconData icon;
  final Color foreground;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s24),
      child: Container(
        width: AppSize.s40,
        height: AppSize.s40,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: foreground,
          size: AppSize.s20,
        ),
      ),
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
