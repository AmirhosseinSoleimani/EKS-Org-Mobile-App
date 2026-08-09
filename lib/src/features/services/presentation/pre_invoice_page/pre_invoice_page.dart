import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/service_invoice_request_context_loader.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/pages/invoice_details_page.dart';
import 'package:flutter/material.dart';

class PreInvoicePage extends StatelessWidget {
  static const path = '/pre-invoice-page';
  static const name = 'pre-invoice-page';

  const PreInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InvoiceDetailsPage(
      requestContextLoader: createServiceInvoiceRequestContextLoader(),
    );
  }
}
