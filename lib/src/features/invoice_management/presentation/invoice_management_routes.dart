import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_pre_invoices/customer_pre_invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvoiceManagementRoutes {
  const InvoiceManagementRoutes._();

  static List<RouteBase> routes(
    Page Function({
      required Widget child,
      required GoRouterState state,
    }) getPage,
  ) {
    return [
      GoRoute(
        path: CustomerPreInvoicePage.path,
        name: CustomerPreInvoicePage.name,
        pageBuilder: (context, state) => getPage(
          child: const CustomerPreInvoicePage(),
          state: state,
        ),
      ),

      // TODO: Add the routes below when their presentation pages are implemented:
      // CustomerInvoicePage
      // EmdadgarPreInvoicePage
      // EmdadgarInvoicePage
      // EmdadgarAmaliatFinalInvoicePage
      // EmdadgarFinalInvoicePage
      // EmdadgarDefiniteInvoicePage
      // InvoiceAgencyObjectionPage
    ];
  }
}
