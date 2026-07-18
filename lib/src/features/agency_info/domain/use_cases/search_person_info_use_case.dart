import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/person_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchPersonInfoUseCase {
  const SearchPersonInfoUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<PersonInfoSearchPageEntity>> call(
    PersonInfoSearchParamEntity param,
  ) {
    return _repository.searchPersons(param);
  }
}
