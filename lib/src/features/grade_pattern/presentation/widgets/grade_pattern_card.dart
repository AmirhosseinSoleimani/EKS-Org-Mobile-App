import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_levels_summary.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
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
      padding: const EdgeInsets.all(AppPadding.p18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TitleLargeText(text:
                _value(item.name),
                  textAlign: TextAlign.right,
                ),
              ),
              Space.w8,
              StatusLabel(text: item.isActive ? 'فعال' : 'غیرفعال',
                color: item.isActive ? theme.colorScheme.onError : theme
                    .colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,),
            ],
          ),
          Space.h16,
          GradePatternLevelsSummary(details: item.details),
          Space.h8,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: Text(
                  'ثبت‌کننده: ${_value(item.insertUserFullName)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                '---',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Space.h12,
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  title: 'مشاهده جزئیات',
                  icon: Icons.visibility_outlined,
                  background: theme.colorScheme.primary,
                  foreground: theme.colorScheme.onPrimary,
                  onTap: onDetails,
                ),
              ),
              Space.w8,
              Expanded(
                child: _OperationsButton(
                  onEdit: onEdit,
                  onDelete: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foreground, size: AppSize.s20),
            Space.w8,
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OperationsButton extends StatelessWidget {
  const _OperationsButton({
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<_GradePatternOperation>(
      onSelected: (value) {
        switch (value) {
          case _GradePatternOperation.edit:
            onEdit();
            break;
          case _GradePatternOperation.delete:
            onDelete();
            break;
        }
      },
      itemBuilder: (context) =>
      const [
        PopupMenuItem(
          value: _GradePatternOperation.edit,
          child: Text('ویرایش'),
        ),
        PopupMenuItem(
          value: _GradePatternOperation.delete,
          child: Text('حذف'),
        ),
      ],
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings_outlined,
                color: theme.colorScheme.onSurfaceVariant),
            Space.w8,
            Text(
              'عملیات',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w800,
              ),
            ),
            Space.w8,
            Icon(Icons.keyboard_arrow_down_rounded,
                color: theme.colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

enum _GradePatternOperation { edit, delete }

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
