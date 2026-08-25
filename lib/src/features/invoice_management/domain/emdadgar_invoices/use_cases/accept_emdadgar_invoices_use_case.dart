import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/bulk_invoice_accept_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/params/bulk_invoice_accept_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/repositories/emdadgar_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcceptEmdadgarInvoicesUseCase {
  const AcceptEmdadgarInvoicesUseCase(this._repository);

  final EmdadgarInvoiceRepository _repository;

  Future<ApiResult<BulkInvoiceAcceptResultEntity>> call(
    BulkInvoiceAcceptParamEntity param,
  ) {
    return _repository.acceptInvoices(param);
  }

  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptFinalApproval(
    BulkInvoiceAcceptParamEntity param,
  ) {
    return _repository.acceptFinalApprovalInvoices(param);
  }

  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptFinalCorrection(
    BulkInvoiceAcceptParamEntity param,
  ) {
    return _repository.acceptFinalCorrectionInvoices(param);
  }
}
