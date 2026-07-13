import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_defects_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVehicleDefectsUseCase extends BaseUseCase<ApiResult<List<VehicleDefectEntity>>, GetVehicleDefectsParamEntity> {
  GetVehicleDefectsUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<VehicleDefectEntity>>> call(GetVehicleDefectsParamEntity arg) async {
    return await _repository.getVehicleDefects(arg);
  }
}
