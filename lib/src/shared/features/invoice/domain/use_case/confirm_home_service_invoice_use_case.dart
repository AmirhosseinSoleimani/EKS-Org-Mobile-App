import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/repository/invoice_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConfirmHomeServiceInvoiceUseCase extends BaseUseCase<
    ApiResult<ConfirmInvoiceResponseEntity?>, ConfirmHomeServiceRequest?> {
  ConfirmHomeServiceInvoiceUseCase(this._repository);

  final InvoiceRepository _repository;

  @override
  Future<ApiResult<ConfirmInvoiceResponseEntity?>> call(arg) async {
    final result = _repository.confirmHomeServiceInvoice(arg);
    return result;
  }
}
