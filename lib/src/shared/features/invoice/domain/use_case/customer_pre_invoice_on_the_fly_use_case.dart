import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/repository/invoice_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CustomerPreInvoiceOnTheFlyUseCase
    extends
        BaseUseCase<ApiResult<InvoiceEntity?>, AcceptEvaluationParamEntity> {
  CustomerPreInvoiceOnTheFlyUseCase(this._repository);

  final InvoiceRepository _repository;

  @override
  Future<ApiResult<InvoiceEntity?>> call(arg) async {
    final result = _repository.customerPreInvoiceOnTheFly(arg);
    return result;
  }

  Future<ApiResult<InvoiceEntity?>> emdadgar(
    AcceptEvaluationParamEntity arg,
  ) async {
    return _repository.emdadgarPreInvoiceOnTheFly(arg);
  }
}
