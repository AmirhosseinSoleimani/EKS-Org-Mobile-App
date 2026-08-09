import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class InvoiceListSectionHeader extends StatelessWidget {
  const InvoiceListSectionHeader({
    super.key,
    required this.title,
    required this.count,
    required this.accentColor,
  });

  final String title;
  final int count;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        StatusLabel(
          text: '${InvoicePresentationFormatter.number(count)} مورد',
          color: accentColor,
          fontSize: 11,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
        ),
      ],
    );
  }
}
