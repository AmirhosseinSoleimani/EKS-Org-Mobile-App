import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

enum GradePatternOperation {
  edit,
  delete,
}

class GradePatternActionSheet extends StatelessWidget {
  const GradePatternActionSheet({
    super.key,
    required this.onActionSelected,
    this.loadingAction,
  });

  final ValueChanged<GradePatternOperation> onActionSelected;
  final GradePatternOperation? loadingAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _GradePatternActionSheetItem(
            icon: Icons.edit_outlined,
            title: 'ویرایش',
            isLoading: _isLoading(GradePatternOperation.edit),
            enabled: !_hasLoading,
            onTap: () => onActionSelected(GradePatternOperation.edit),
          ),
          Divider(
            height: AppSize.s1,
            thickness: AppSize.s1,
            color: theme.colorScheme.onInverseSurface,
          ),
          _GradePatternActionSheetItem(
            icon: Icons.delete_outline_rounded,
            title: 'حذف',
            isDestructive: true,
            isLoading: _isLoading(GradePatternOperation.delete),
            enabled: !_hasLoading,
            onTap: () => onActionSelected(GradePatternOperation.delete),
          ),
        ],
      ),
    );
  }

  bool get _hasLoading => loadingAction != null;

  bool _isLoading(GradePatternOperation action) => loadingAction == action;
}

class _GradePatternActionSheetItem extends StatelessWidget {
  const _GradePatternActionSheetItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
    this.isLoading = false,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.onPrimaryFixed;
    final effectiveColor = enabled || isLoading ? color : color.withOpacity(0.45);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: AppSize.s24,
        height: AppSize.s24,
        child: isLoading
            ? CircularProgressIndicator(
                strokeWidth: 2,
                color: effectiveColor,
              )
            : Icon(icon, color: effectiveColor, size: AppSize.s24),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: effectiveColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: enabled && !isLoading ? onTap : null,
    );
  }
}
