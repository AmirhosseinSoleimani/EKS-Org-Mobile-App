import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/add_agency_vehicle_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

import '../entities/params/add_agency_vehicle_param_entity.dart';

@injectable
class AddAgencyVehicleUseCase {
  const AddAgencyVehicleUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<AddAgencyVehicleEntity>> call(
      AddAgencyVehicleParamEntity param,
      ) {
    return _repository.addVehicle(param);
  }
}