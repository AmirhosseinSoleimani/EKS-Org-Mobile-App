import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/delete_agency_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAgencyUseCase {
  const DeleteAgencyUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<void>> call(DeleteAgencyParamEntity param) {
    return _repository.deleteAgency(param);
  }
}
