import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/add_agency_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_person_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAgencyPersonUseCase {
  const AddAgencyPersonUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<AddAgencyPersonEntity>> call(
    AddAgencyPersonParamEntity param,
  ) {
    return _repository.addPerson(param);
  }
}
