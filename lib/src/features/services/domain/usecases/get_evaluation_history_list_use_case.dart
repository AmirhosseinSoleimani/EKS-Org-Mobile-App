import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/params/service_request_param_entity.dart';

@lazySingleton
class GetEvaluationHistoryListUseCase extends BaseUseCase<
    ApiResult<List<EvaluationHistoryItemEntity>>,
    ServiceRequestParamEntity> {
  final RequestRepository _repository;

  GetEvaluationHistoryListUseCase(this._repository);

  @override
  Future<ApiResult<List<EvaluationHistoryItemEntity>>> call(arg) async {
    return await _repository.getEvaluationHistory(arg);
  }
}
