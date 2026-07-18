import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/change_agency_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeAgencyStatusUseCase {
  const ChangeAgencyStatusUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<void>> call(ChangeAgencyStatusParamEntity param) {
    return _repository.changeStatus(param);
  }
}
