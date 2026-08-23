import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
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

    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.edit_outlined,
            title: 'ویرایش',
            isLoading: _isLoading(ShiftOperation.edit),
            onTap: () {
              if (_hasLoading) return;
              onActionSelected(ShiftOperation.edit);
            },
          ),
          dividerAfter: Divider(
            height: AppSize.s1,
            thickness: AppSize.s1,
            color: theme.colorScheme.onInverseSurface,
          ),
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.delete_outline_rounded,
            title: 'حذف',
            isDestructive: true,
            isLoading: _isLoading(ShiftOperation.delete),
            onTap: () {
              if (_hasLoading) return;
              onActionSelected(ShiftOperation.delete);
            },
          ),
        ),
      ],
    );
  }

  bool get _hasLoading => loadingAction != null;

  bool _isLoading(ShiftOperation action) => loadingAction == action;
}
