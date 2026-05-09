import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/params/service_invoice_param_model.dart';

abstract class InvoiceDataSource {

  Future<BaseSingleResponse<InvoiceModel?>> getPreInvoice(ServiceInvoiceParamModel? param);

  Future<BaseSingleResponse<InvoiceModel?>> getEmdadgarInvoice(
      ServiceInvoiceParamModel? param);

  Future<BaseSingleResponse<InvoiceModel?>> customerPreInvoiceOnTheFly(
      AcceptEvaluationParamModel param);
}
