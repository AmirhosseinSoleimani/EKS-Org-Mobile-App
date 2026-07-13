import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_defect_limitation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitVehicleDefectLimitationUseCase extends BaseUseCase<ApiResult<void>, SubmitVehicleDefectLimitationParamEntity> {
  SubmitVehicleDefectLimitationUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<void>> call(SubmitVehicleDefectLimitationParamEntity arg) async {
    return await _repository.submitVehicleDefectLimitation(arg);
  }
}
