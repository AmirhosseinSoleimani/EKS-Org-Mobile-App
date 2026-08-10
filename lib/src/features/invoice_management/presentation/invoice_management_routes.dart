import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/agency_correction_requests_page.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_invoices/customer_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_pre_invoices/customer_pre_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoices/emdadgar_invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvoiceManagementRoutes {
  const InvoiceManagementRoutes._();

  static List<RouteBase> routes(Page Function({
      required Widget child,
      required GoRouterState state,
  }) getPage,) {
    return [
      GoRoute(
        path: CustomerPreInvoicePage.path,
        name: CustomerPreInvoicePage.name,
        pageBuilder: (context, state) => getPage(
          child: const CustomerPreInvoicePage(),
          state: state,
        ),
      ),

      GoRoute(
        path: CustomerInvoicePage.path,
        name: CustomerInvoicePage.name,
        pageBuilder: (context, state) => getPage(
          child: const CustomerInvoicePage(),
          state: state,
        ),
      ),

      GoRoute(
        path: EmdadgarInvoicePage.path,
        name: EmdadgarInvoicePage.name,
        pageBuilder: (context, state) =>
            getPage(
              child: EmdadgarInvoicePage(
                initialStage: state.extra is EmdadgarInvoiceStage
                    ? state.extra! as EmdadgarInvoiceStage
                    : EmdadgarInvoiceStage.initial,
              ),
              state: state,
            ),
      ),

      GoRoute(
        path: AgencyCorrectionRequestsPage.path,
        name: AgencyCorrectionRequestsPage.name,
        pageBuilder: (context, state) =>
            getPage(
              child: const AgencyCorrectionRequestsPage(),
              state: state,
            ),
      ),
    ];
  }
}
