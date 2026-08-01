import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/repository/vehicle_model_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitVehicleDefectsUseCase
    extends BaseUseCase<ApiResult<String>, VehicleModelIdsPayloadParamEntity> {
  SubmitVehicleDefectsUseCase(this._repository);

  final VehicleModelRepository _repository;

  @override
  Future<ApiResult<String>> call(VehicleModelIdsPayloadParamEntity arg) =>
      _repository.submitDefects(arg);
}
