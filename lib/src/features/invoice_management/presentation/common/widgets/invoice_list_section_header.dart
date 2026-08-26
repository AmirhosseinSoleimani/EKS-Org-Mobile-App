import 'package:eks_sana_plus_org/src/shared/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
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
    return ListSectionHeader(
      title: title,
      countText: '${InvoicePresentationFormatter.number(count)} مورد',
      accentColor: accentColor,
    );
  }
}
