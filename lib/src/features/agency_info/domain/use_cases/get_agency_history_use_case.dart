import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAgencyHistoryUseCase {
  const GetAgencyHistoryUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<List<AgencyHistoryEntity>>> call(
    AgencyHistoryParamEntity param,
  ) {
    return _repository.getHistory(param);
  }
}
