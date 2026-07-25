import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAgencyContractUseCase {
  const AddAgencyContractUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<String>> call(AddAgencyContractParamEntity param) {
    return _repository.addContract(param);
  }
}
