import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEmdadUnitLookupsUseCase {
  const GetEmdadUnitLookupsUseCase(this._repository);

  final EmdadUnitRepository _repository;

  Future<ApiResult<List<LookupEntity>>> getAgencies() => _repository.getAgencies();

  Future<ApiResult<List<LookupEntity>>> getAgencyPersons(int agencyInfoId) {
    return _repository.getAgencyPersons(agencyInfoId);
  }

  Future<ApiResult<List<LookupEntity>>> getAgencyVehicles(int agencyInfoId) {
    return _repository.getAgencyVehicles(agencyInfoId);
  }

  Future<ApiResult<List<LookupEntity>>> getActiveLocations() {
    return _repository.getActiveLocations();
  }
}
