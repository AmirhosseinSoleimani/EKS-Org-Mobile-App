import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/submit_vehicle_services_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitVehicleServicesUseCase extends BaseUseCase<ApiResult<SubmitVehicleServicesResponseEntity>, SubmitVehicleServicesParamEntity> {
  SubmitVehicleServicesUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<SubmitVehicleServicesResponseEntity>> call(SubmitVehicleServicesParamEntity arg) async {
    return await _repository.submitVehicleServices(arg);
  }
}
