import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EmdadUnitActionSheet extends StatelessWidget {
  const EmdadUnitActionSheet({
    super.key,
    required this.onEditImage,
    required this.onChangeLocation,
    required this.onPersons,
    required this.onGradePatterns,
    required this.onDelete,
  });

  final VoidCallback onEditImage;
  final VoidCallback onChangeLocation;
  final VoidCallback onPersons;
  final VoidCallback onGradePatterns;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divider = Divider(
      height: AppSize.s1,
      thickness: AppSize.s1,
      color: theme.colorScheme.onInverseSurface,
    );

    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.group_outlined,
            title: 'امدادرسان‌ها',
            onTap: onPersons,
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.grading_outlined,
            title: 'الگوی گرید',
            onTap: onGradePatterns,
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.bus_alert_outlined,
            title: 'تغییر محل استقرار',
            onTap: onChangeLocation,
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.delete_outlined,
            title: 'حذف',
            isDestructive: true,
            onTap: onDelete,
          ),
        ),
      ],
    );
  }
}
