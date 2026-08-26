import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_result_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';

abstract class EmdadgarInvoiceDataSource {
  Future<BaseSingleResponse<EmdadgarInvoicePageModel>> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<InvoiceModel?>> getInitialInvoiceDetails(
    InvoiceDetailsRequestModel request,
  );

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>>
      acceptInitialInvoices(
    BulkInvoiceAcceptParamModel request,
  );

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>> getInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>> acceptInvoices(
    BulkInvoiceAcceptParamModel request,
  );

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>>
      acceptFinalApprovalInvoices(
    BulkInvoiceAcceptParamModel request,
  );

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>>
      getFinalApprovalInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>>
      acceptFinalCorrectionInvoices(
    BulkInvoiceAcceptParamModel request,
  );

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>>
      getFinalCorrectionInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>> getDefiniteInvoices(
    InvoiceListFilterRequestModel request,
  );
}
