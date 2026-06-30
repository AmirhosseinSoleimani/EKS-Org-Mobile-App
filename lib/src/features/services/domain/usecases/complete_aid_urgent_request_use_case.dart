import 'package:eks_sana_plus_org/src/features/services/domain/entities/complete_urgent_request_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/complete_urgent_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CompleteAidUrgentRequestUseCase
    extends
        BaseUseCase<
          ApiResult<CompleteUrgentRequestDataEntity>,
          CompleteUrgentParamEntity
        > {
  final RequestRepository _repository;

  CompleteAidUrgentRequestUseCase(this._repository);

  @override
  Future<ApiResult<CompleteUrgentRequestDataEntity>> call(
    CompleteUrgentParamEntity arg,
  ) async {
    return await _repository.completeAidUrgentRequest(arg);
  }
}
