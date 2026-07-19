import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAgencyInfoByIdUseCase {
  const GetAgencyInfoByIdUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<AgencyInfoEntity>> call(int id) {
    return _repository.getById(id);
  }
}
