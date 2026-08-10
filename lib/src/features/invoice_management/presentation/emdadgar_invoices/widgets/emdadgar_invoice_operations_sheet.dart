import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceOperationsSheet extends StatelessWidget {
  const EmdadgarInvoiceOperationsSheet({
    super.key,
    required this.onDetailsTap,
    required this.onCorrectionTap,
    this.correctionEnabled = true,
  });

  final VoidCallback onDetailsTap;
  final VoidCallback onCorrectionTap;
  final bool correctionEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetActionTile(
          icon: Icons.info_outline,
          title: 'مشاهده جزئیات',
          onTap: onDetailsTap,
        ),
        BottomSheetActionTile(
          icon: Icons.edit_outlined,
          title: 'اصلاح صورت وضعیت',
          enabled: correctionEnabled,
          onTap: onCorrectionTap,
        ),
      ],
    );
  }
}
