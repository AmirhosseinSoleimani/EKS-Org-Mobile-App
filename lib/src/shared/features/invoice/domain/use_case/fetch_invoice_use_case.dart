import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/repository/invoice_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchInvoiceUseCase extends BaseUseCase<ApiResult<InvoiceResponseEntity?>, ServiceInvoiceRequestEntity?> {
  FetchInvoiceUseCase(this._repository);

  final InvoiceRepository _repository;

  @override
  Future <ApiResult<InvoiceResponseEntity?>> call(arg) async{
    final result = _repository.fetchInvoice(arg);
    return result;
  }
}
