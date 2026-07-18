import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAgencyContractsUseCase {
  const GetAgencyContractsUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<AgencyContractPageEntity>> call(
    AgencyContractParamEntity param,
  ) {
    return _repository.getContracts(param);
  }
}
