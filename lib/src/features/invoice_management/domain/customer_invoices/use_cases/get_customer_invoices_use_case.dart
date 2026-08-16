import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/repositories/customer_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCustomerInvoicesUseCase {
  const GetCustomerInvoicesUseCase(this._repository);

  final CustomerInvoiceRepository _repository;

  Future<ApiResult<InvoiceRecordPageEntity>> call(InvoiceListFilterParamEntity param) {
    return _repository.getInvoices(param);
  }
}
