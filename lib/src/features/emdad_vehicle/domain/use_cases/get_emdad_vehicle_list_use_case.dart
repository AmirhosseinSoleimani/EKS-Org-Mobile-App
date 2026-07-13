import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_emdad_vehicle_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEmdadVehicleListUseCase extends BaseUseCase<ApiResult<List<VehicleModelEntity>>, GetEmdadVehicleListParamEntity> {
  GetEmdadVehicleListUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<VehicleModelEntity>>> call(GetEmdadVehicleListParamEntity arg) async {
    return await _repository.getEmdadVehicleList(arg);
  }
}
