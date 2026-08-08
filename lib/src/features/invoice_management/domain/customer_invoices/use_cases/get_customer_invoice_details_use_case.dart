import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/repositories/customer_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCustomerInvoiceDetailsUseCase {
  const GetCustomerInvoiceDetailsUseCase(this._repository);

  final CustomerInvoiceRepository _repository;

  Future<ApiResult<InvoiceEntity?>> call(InvoiceDetailsParamEntity param) {
    return _repository.getDetails(param);
  }
}
