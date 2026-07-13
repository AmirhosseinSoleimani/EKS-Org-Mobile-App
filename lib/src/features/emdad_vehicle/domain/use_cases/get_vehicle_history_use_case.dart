import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVehicleHistoryUseCase extends BaseUseCase<ApiResult<List<VehicleHistoryEntity>>, GetVehicleHistoryParamEntity> {
  GetVehicleHistoryUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<VehicleHistoryEntity>>> call(GetVehicleHistoryParamEntity arg) async {
    return await _repository.getVehicleHistory(arg);
  }
}
