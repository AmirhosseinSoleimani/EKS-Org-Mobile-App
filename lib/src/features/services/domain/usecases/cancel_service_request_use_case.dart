import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CancelServiceRequestUseCase
    extends BaseUseCase<ApiResult<void>, CancelRequestParamEntity> {
  final RequestRepository _repository;

  CancelServiceRequestUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(CancelRequestParamEntity arg) async {
    return await _repository.cancelServiceRequest(arg);
  }
}
