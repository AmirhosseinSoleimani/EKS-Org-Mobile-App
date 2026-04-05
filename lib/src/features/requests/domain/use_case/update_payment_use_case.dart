import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/payment_type_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/payment_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdatePaymentUseCase
    extends BaseUseCase<ApiResult<PaymentResultEntity>, PaymentTypeParam> {
  final RequestRepository _repository;

  UpdatePaymentUseCase(this._repository);

  @override
  Future<ApiResult<PaymentResultEntity>> call(arg) async {
    return await _repository.updatePaymentType(arg);
  }
}
