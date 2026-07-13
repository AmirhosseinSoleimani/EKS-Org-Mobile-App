import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_active_vehicle_models_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetActiveVehicleModelsUseCase extends BaseUseCase<ApiResult<List<VehicleModelEntity>>, GetActiveVehicleModelsParamEntity> {
  GetActiveVehicleModelsUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<VehicleModelEntity>>> call(GetActiveVehicleModelsParamEntity arg) async {
    return await _repository.getActiveVehicleModels(arg);
  }
}
