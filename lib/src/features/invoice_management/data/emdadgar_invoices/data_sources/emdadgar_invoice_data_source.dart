import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_result_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';

abstract class EmdadgarInvoiceDataSource {
  Future<EmdadgarInvoicePageModel> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<InvoiceModel?>> getInitialInvoiceDetails(
    InvoiceDetailsRequestModel request,
  );

  Future<BulkInvoiceAcceptResultModel> acceptInitialInvoices(
    BulkInvoiceAcceptParamModel request,
  );

  Future<EmdadgarInvoicePageModel> getInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BulkInvoiceAcceptResultModel> acceptInvoices(
    BulkInvoiceAcceptParamModel request,
  );

  Future<EmdadgarInvoicePageModel> getFinalApprovalInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<EmdadgarInvoicePageModel> getFinalCorrectionInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<EmdadgarInvoicePageModel> getDefiniteInvoices(
    InvoiceListFilterRequestModel request,
  );
}
