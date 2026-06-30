import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRequestStatusHistoryUseCase extends BaseUseCase<
    ApiResult<RequestStatusHistoryListEntity>, RequestOperationParamEntity> {
  final RequestRepository _repository;

  GetRequestStatusHistoryUseCase(this._repository);

  @override
  Future<ApiResult<RequestStatusHistoryListEntity>> call(arg) async {
    return await _repository.getRequestStatusHistory(arg);
  }
}
