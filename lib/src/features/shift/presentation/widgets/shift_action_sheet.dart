import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

enum ShiftOperation { edit, delete }

class ShiftActionSheet extends StatelessWidget {
  const ShiftActionSheet({
    super.key,
    required this.onActionSelected,
    this.loadingAction,
  });

  final ValueChanged<ShiftOperation> onActionSelected;
  final ShiftOperation? loadingAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ShiftActionSheetItem(
              icon: Icons.edit_outlined,
              title: 'ویرایش',
              isLoading: _isLoading(ShiftOperation.edit),
              onTap: () {
                if (_hasLoading) return;
                onActionSelected(ShiftOperation.edit);
              },
            ),
            Divider(
              height: AppSize.s1,
              thickness: AppSize.s1,
              color: theme.colorScheme.onInverseSurface,
            ),
            _ShiftActionSheetItem(
              icon: Icons.delete_outline_rounded,
              title: 'حذف',
              isDestructive: true,
              isLoading: _isLoading(ShiftOperation.delete),
              onTap: () {
                if (_hasLoading) return;
                onActionSelected(ShiftOperation.delete);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool get _hasLoading => loadingAction != null;

  bool _isLoading(ShiftOperation action) => loadingAction == action;
}

class _ShiftActionSheetItem extends StatelessWidget {
  const _ShiftActionSheetItem({
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
    final color =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.onPrimaryFixed;
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
        textAlign: TextAlign.right,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: effectiveColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: enabled
          ? () {
              if (isLoading) return;
              onTap();
            }
          : null,
    );
  }
}
