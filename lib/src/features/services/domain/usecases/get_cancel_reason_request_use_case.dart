import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCancelReasonRequestUseCase
    extends
        BaseUseCase<
          ApiResult<List<CancelRequestReasonEntity>>,
          CancelReasonParamEntity
        > {
  final RequestRepository _repository;

  GetCancelReasonRequestUseCase(this._repository);

  @override
  Future<ApiResult<List<CancelRequestReasonEntity>>> call(arg) async {
    return await _repository.getCancelReasons(arg);
  }
}
