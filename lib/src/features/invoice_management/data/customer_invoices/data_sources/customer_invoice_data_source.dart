import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';

abstract class CustomerInvoiceDataSource {
  Future<BaseSingleResponse<InvoiceRecordPageModel>> getPreInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<InvoiceRecordPageModel>> getInvoices(
    InvoiceListFilterRequestModel request,
  );

  Future<BaseSingleResponse<InvoiceModel?>> getDetails(
    InvoiceDetailsRequestModel request,
  );

  Future<BaseSingleResponse<String>> finalizeInvoice(
    InvoiceDetailsRequestModel request,
  );
}
