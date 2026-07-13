import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/emdad_vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_emdad_vehicle_by_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEmdadVehicleByIdUseCase extends BaseUseCase<ApiResult<EmdadVehicleInfoEntity>, GetEmdadVehicleByIdParamEntity> {
  GetEmdadVehicleByIdUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<EmdadVehicleInfoEntity>> call(GetEmdadVehicleByIdParamEntity arg) async {
    return await _repository.getEmdadVehicleById(arg);
  }
}
