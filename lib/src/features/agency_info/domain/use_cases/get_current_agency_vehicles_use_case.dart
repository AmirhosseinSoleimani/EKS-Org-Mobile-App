import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentAgencyVehiclesUseCase {
  const GetCurrentAgencyVehiclesUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<AgencyVehiclePageEntity>> call(
    AgencyInfoIdParamEntity param,
  ) {
    return _repository.getCurrentVehicles(param);
  }
}
