import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/repositories/emdadgar_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInitialEmdadgarInvoiceDetailsUseCase {
  const GetInitialEmdadgarInvoiceDetailsUseCase(this._repository);

  final EmdadgarInvoiceRepository _repository;

  Future<ApiResult<InvoiceEntity?>> call(InvoiceDetailsParamEntity param) {
    return _repository.getInitialInvoiceDetails(param);
  }
}
