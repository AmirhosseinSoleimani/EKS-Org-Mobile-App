import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/data_sources/emdadgar_invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_result_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/services/emdadgar_invoice_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmdadgarInvoiceDataSource)
class EmdadgarInvoiceDataSourceImpl implements EmdadgarInvoiceDataSource {
  const EmdadgarInvoiceDataSourceImpl(this._service);

  final EmdadgarInvoiceService _service;

  @override
  Future<EmdadgarInvoicePageModel> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getInitialInvoices(request);

  @override
  Future<BaseSingleResponse<InvoiceModel?>> getInitialInvoiceDetails(
    InvoiceDetailsRequestModel request,
  ) => _service.getInitialInvoiceDetails(request);

  @override
  Future<BulkInvoiceAcceptResultModel> acceptInitialInvoices(
    BulkInvoiceAcceptParamModel request,
  ) => _service.acceptInitialInvoices(request);

  @override
  Future<EmdadgarInvoicePageModel> getInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getInvoices(request);

  @override
  Future<BulkInvoiceAcceptResultModel> acceptInvoices(
    BulkInvoiceAcceptParamModel request,
  ) => _service.acceptInvoices(request);

  @override
  Future<BulkInvoiceAcceptResultModel> acceptFinalApprovalInvoices(
    BulkInvoiceAcceptParamModel request,
  ) => _service.acceptFinalApprovalInvoices(request);

  @override
  Future<EmdadgarInvoicePageModel> getFinalApprovalInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getFinalApprovalInvoices(request);

  @override
  Future<BulkInvoiceAcceptResultModel> acceptFinalCorrectionInvoices(
    BulkInvoiceAcceptParamModel request,
  ) => _service.acceptFinalCorrectionInvoices(request);

  @override
  Future<EmdadgarInvoicePageModel> getFinalCorrectionInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getFinalCorrectionInvoices(request);

  @override
  Future<EmdadgarInvoicePageModel> getDefiniteInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getDefiniteInvoices(request);
}
