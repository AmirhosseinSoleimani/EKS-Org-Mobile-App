import 'package:eks_sana_plus_org/src/shared/extensions/color_extension.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:flutter/material.dart';

class InvoiceAmountSummary extends StatelessWidget {
  const InvoiceAmountSummary({
    super.key,
    required this.customerAmount,
    required this.companyAmount,
    required this.highlightColor,
  });

  final int? customerAmount;
  final int? companyAmount;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.dividerColor.withOpacity(0.6)),
      ),
      child: Column(
        children: [
          AmountRow(
            label: 'مبلغ پرداختی شرکت',
            amount: companyAmount,
            valueColor: theme.colorScheme.onSurfaceVariant,
          ),
          Space.h8,
          AmountRow(
            label: 'مبلغ پرداختی مشتری',
            amount: customerAmount,
            valueColor: highlightColor.darken(),
            isEmphasized: true,
          ),
        ],
      ),
    );
  }
}
