import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRequestFollowupHistoryUseCase extends BaseUseCase<
    ApiResult<List<FollowupEntity>>, ServiceRequestParamEntity> {
  final RequestRepository _repository;

  GetRequestFollowupHistoryUseCase(this._repository);

  @override
  Future<ApiResult<List<FollowupEntity>>> call(arg) async {
    return await _repository.getRequestFollowupHistory(arg);
  }
}
