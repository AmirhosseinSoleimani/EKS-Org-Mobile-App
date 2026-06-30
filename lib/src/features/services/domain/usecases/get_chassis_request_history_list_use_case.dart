import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetChassisRequestHistoryListUseCase extends BaseUseCase<
    ApiResult<List<ChassisRequestHistoryEntity>>, ChassisParamEntity> {
  final RequestRepository _repository;

  GetChassisRequestHistoryListUseCase(this._repository);

  @override
  Future<ApiResult<List<ChassisRequestHistoryEntity>>> call(arg) async {
    return await _repository.getChassisRequestHistoryList(arg);
  }
}
