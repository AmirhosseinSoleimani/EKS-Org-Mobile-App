import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SpecialPlanActionSheet extends StatelessWidget {
  const SpecialPlanActionSheet({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.isDeleting = false,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.edit_outlined,
            title: 'ویرایش',
            onTap: () {
              if (isDeleting) return;
              onEdit();
            },
          ),
          dividerAfter: Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.delete_outline,
            title: 'حذف',
            isDestructive: true,
            isLoading: isDeleting,
            onTap: () {
              if (isDeleting) return;
              onDelete();
            },
          ),
        ),
      ],
    );
  }
}
