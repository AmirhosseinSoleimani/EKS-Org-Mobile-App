import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/color_extension.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
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
          _AmountRow(
            label: 'مبلغ پرداختی شرکت',
            value: InvoicePresentationFormatter.rial(companyAmount),
            valueColor: theme.colorScheme.onSurfaceVariant,
            isEmphasized: false,
          ),
          Space.h8,
          _AmountRow(
            label: 'مبلغ پرداختی مشتری',
            value: InvoicePresentationFormatter.rial(customerAmount),
            valueColor: highlightColor.darken(),
            isEmphasized: true,
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.isEmphasized,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool isEmphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: isEmphasized ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Space.w8,
        Text(
          value,
          textDirection: TextDirection.rtl,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: isEmphasized ? FontWeight.w800 : FontWeight.w600,
            fontSize: isEmphasized ? AppSize.s16 : AppSize.s12,
          ),
        ),
      ],
    );
  }
}
