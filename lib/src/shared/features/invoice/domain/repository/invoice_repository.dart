import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';

abstract class InvoiceRepository {
  Future<ApiResult<InvoiceEntity?>> getPreInvoice(ServiceInvoiceParamEntity? entity);
  Future<ApiResult<InvoiceEntity?>> getEmdadgardInvoice(ServiceInvoiceParamEntity? entity);

  Future<ApiResult<InvoiceEntity?>> customerPreInvoiceOnTheFly(
      AcceptEvaluationParamEntity param);

  Future<ApiResult<InvoiceEntity?>> emdadgarPreInvoiceOnTheFly(
      AcceptEvaluationParamEntity param);
}
