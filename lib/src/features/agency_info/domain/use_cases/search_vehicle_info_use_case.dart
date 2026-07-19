import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/vehicle_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchVehicleInfoUseCase {
  const SearchVehicleInfoUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<VehicleInfoSearchPageEntity>> call(
    VehicleInfoSearchParamEntity param,
  ) {
    return _repository.searchVehicles(param);
  }
}
