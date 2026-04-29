import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/repository/invoice_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEmdadgarInvoiceUseCase extends BaseUseCase<ApiResult<InvoiceEntity?>, ServiceInvoiceParamEntity?> {
  GetEmdadgarInvoiceUseCase(this._repository);

  final InvoiceRepository _repository;

  @override
  Future <ApiResult<InvoiceEntity?>> call(arg) async{
    final result = _repository.getEmdadgardInvoice(arg);
    return result;
  }
}
