import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/service_invoice_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_response_model.dart';

abstract class InvoiceDataSource {

  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchInvoice(ServiceInvoiceRequestModel? model);

  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchPreInvoice(ServiceInvoiceRequestModel? model);

  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchPreInvoiceOnTheFly(ServiceInvoiceRequestModel? model);

  Future<BaseSingleResponse<ConfirmInvoiceResponseModel?>> confirmHomeServiceInvoice(ConfirmInvoiceRequestModel? model);

}
