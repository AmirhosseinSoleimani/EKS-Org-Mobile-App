import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class NavganActionSheet extends StatelessWidget {
  const NavganActionSheet({
    super.key,
    required this.onAddGrade,
    required this.onServices,
  });

  final VoidCallback onAddGrade;
  final VoidCallback onServices;

  @override
  Widget build(BuildContext context) {
    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.grading_outlined,
            title: 'الگوی گرید',
            onTap: onAddGrade,
          ),
        ),
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.miscellaneous_services_outlined,
            title: 'سرویس‌ها',
            onTap: onServices,
          ),
        ),
      ],
    );
  }
}
