import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/params/service_invoice_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';

abstract class InvoiceDataSource {

  Future<BaseSingleResponse<InvoiceModel?>> getPreInvoice(ServiceInvoiceParamModel? model);
}
