import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceOperationsSheet extends StatelessWidget {
  const EmdadgarInvoiceOperationsSheet({
    super.key,
    required this.onDetailsTap,
    this.onCorrectionTap,
  });

  final VoidCallback onDetailsTap;
  final VoidCallback? onCorrectionTap;

  @override
  Widget build(BuildContext context) {
    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.info_outline,
            title: 'مشاهده جزئیات',
            onTap: onDetailsTap,
          ),
        ),
        if (onCorrectionTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'اصلاح صورت وضعیت',
              onTap: onCorrectionTap!,
            ),
          ),
      ],
    );
  }
}
