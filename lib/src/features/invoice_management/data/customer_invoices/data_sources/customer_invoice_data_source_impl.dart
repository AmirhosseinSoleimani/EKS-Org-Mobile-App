import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/customer_invoices/data_sources/customer_invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/customer_invoices/services/customer_invoice_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CustomerInvoiceDataSource)
class CustomerInvoiceDataSourceImpl implements CustomerInvoiceDataSource {
  const CustomerInvoiceDataSourceImpl(this._service);

  final CustomerInvoiceService _service;

  @override
  Future<InvoiceRecordPageModel> getPreInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getPreInvoices(request);

  @override
  Future<InvoiceRecordPageModel> getInvoices(
    InvoiceListFilterRequestModel request,
  ) => _service.getInvoices(request);

  @override
  Future<BaseSingleResponse<InvoiceModel?>> getDetails(
    InvoiceDetailsRequestModel request,
  ) => _service.getDetails(request);

  @override
  Future<BaseSingleResponse<String>> finalizeInvoice(
    InvoiceDetailsRequestModel request,
  ) => _service.finalizeInvoice(request);
}
