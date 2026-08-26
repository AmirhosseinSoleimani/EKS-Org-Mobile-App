import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:flutter/material.dart';

class InvoiceRow extends StatelessWidget {
  final String label;
  final num? customerValue;
  final num? companyValue;

  const InvoiceRow({
    super.key,
    required this.label,
    required this.customerValue,
    required this.companyValue,
  });

  @override
  Widget build(BuildContext context) {
    const valueStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
    );

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: valueStyle),
        ),
        Expanded(
          child: AmountRow(
            amount: customerValue,
            showRial: false,
            valueStyle: valueStyle,
            valueAlignment: Alignment.center,
          ),
        ),
        Expanded(
          child: AmountRow(
            amount: companyValue,
            showRial: false,
            valueStyle: valueStyle,
            valueAlignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
