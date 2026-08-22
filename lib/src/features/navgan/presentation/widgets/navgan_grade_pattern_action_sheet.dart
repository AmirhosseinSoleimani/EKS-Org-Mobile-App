import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:flutter/material.dart';

enum NavganGradePatternOperation {
  delete,
}

class NavganGradePatternActionSheet extends StatelessWidget {
  const NavganGradePatternActionSheet({
    super.key,
    required this.onActionSelected,
    this.loadingAction,
  });

  final ValueChanged<NavganGradePatternOperation> onActionSelected;
  final NavganGradePatternOperation? loadingAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetActionTile(
            icon: Icons.delete_outline_rounded,
            title: 'حذف',
            isDestructive: true,
            isLoading: _isLoading(NavganGradePatternOperation.delete),
            onTap: () {
              if (_hasLoading) return;
              onActionSelected(NavganGradePatternOperation.delete);
            },
          ),
        ],
      ),
    );
  }

  bool get _hasLoading => loadingAction != null;

  bool _isLoading(NavganGradePatternOperation action) {
    return loadingAction == action;
  }
}
