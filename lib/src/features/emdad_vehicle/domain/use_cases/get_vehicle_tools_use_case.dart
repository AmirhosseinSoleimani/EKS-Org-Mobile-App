import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_tools_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVehicleToolsUseCase extends BaseUseCase<ApiResult<List<VehicleToolEntity>>, GetVehicleToolsParamEntity> {
  GetVehicleToolsUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<VehicleToolEntity>>> call(GetVehicleToolsParamEntity arg) async {
    return await _repository.getVehicleTools(arg);
  }
}
