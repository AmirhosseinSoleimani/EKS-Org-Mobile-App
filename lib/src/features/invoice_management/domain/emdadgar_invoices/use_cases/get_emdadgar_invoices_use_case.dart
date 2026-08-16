import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/repositories/emdadgar_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEmdadgarInvoicesUseCase {
  const GetEmdadgarInvoicesUseCase(this._repository);

  final EmdadgarInvoiceRepository _repository;

  Future<ApiResult<EmdadgarInvoicePageEntity>> call(
    InvoiceListFilterParamEntity param,
  ) {
    return _repository.getInvoices(param);
  }
}
