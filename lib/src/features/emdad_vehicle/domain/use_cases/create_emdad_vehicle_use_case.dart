import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_id_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/create_emdad_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateEmdadVehicleUseCase extends BaseUseCase<ApiResult<VehicleIdResponseEntity>, CreateEmdadVehicleParamEntity> {
  CreateEmdadVehicleUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<VehicleIdResponseEntity>> call(CreateEmdadVehicleParamEntity arg) async {
    return await _repository.createEmdadVehicle(arg);
  }
}
