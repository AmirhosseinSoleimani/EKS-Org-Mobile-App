import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_id_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/delete_emdad_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteEmdadVehicleUseCase extends BaseUseCase<ApiResult<VehicleIdResponseEntity>, DeleteEmdadVehicleParamEntity> {
  DeleteEmdadVehicleUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<VehicleIdResponseEntity>> call(DeleteEmdadVehicleParamEntity arg) async {
    return await _repository.deleteEmdadVehicle(arg);
  }
}
