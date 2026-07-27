import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
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
          BottomSheetActionTile(
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
          BottomSheetActionTile(
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

