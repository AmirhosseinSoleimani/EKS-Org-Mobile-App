import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceOperationsSheet extends StatelessWidget {
  const EmdadgarInvoiceOperationsSheet({
    super.key,
    required this.onDetailsTap,
    this.onCustomerPreInvoiceTap,
    this.onCustomerInvoiceTap,
    this.onCustomerCorrectionTap,
    this.onEmdadgarCorrectionTap,
    this.onHesabdariCorrectionTap,
    this.onDaraeiCorrectionTap,
    this.onAcceptTap,
  });

  final VoidCallback onDetailsTap;
  final VoidCallback? onCustomerPreInvoiceTap;
  final VoidCallback? onCustomerInvoiceTap;
  final VoidCallback? onCustomerCorrectionTap;
  final VoidCallback? onEmdadgarCorrectionTap;
  final VoidCallback? onHesabdariCorrectionTap;
  final VoidCallback? onDaraeiCorrectionTap;
  final VoidCallback? onAcceptTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: OperationBottomSheet(
        entries: [
        OperationBottomSheetEntry(
          child: BottomSheetActionTile(
            icon: Icons.info_outline,
            title: 'مشاهده جزئیات',
            onTap: onDetailsTap,
          ),
        ),
        if (onCustomerPreInvoiceTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.receipt_long_outlined,
              title: 'مشاهده پیش فاکتور مشتری',
              onTap: onCustomerPreInvoiceTap!,
            ),
          ),
        if (onCustomerInvoiceTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.receipt_outlined,
              title: 'مشاهده فاکتور مشتری',
              onTap: onCustomerInvoiceTap!,
            ),
          ),
        if (onCustomerCorrectionTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'اصلاح فاکتور مشتری',
              onTap: onCustomerCorrectionTap!,
            ),
          ),
        if (onEmdadgarCorrectionTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'اصلاح صورت وضعیت نماینده',
              onTap: onEmdadgarCorrectionTap!,
            ),
          ),
        if (onHesabdariCorrectionTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'اصلاح صورت وضعیت نماینده',
              onTap: onHesabdariCorrectionTap!,
            ),
          ),
        if (onDaraeiCorrectionTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'اصلاح صورت وضعیت نماینده',
              onTap: onDaraeiCorrectionTap!,
            ),
          ),
        if (onAcceptTap != null)
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.check_circle_outline,
              title: 'تایید صورت وضعیت',
              onTap: onAcceptTap!,
            ),
          ),
        ],
      ),
    );
  }
}
