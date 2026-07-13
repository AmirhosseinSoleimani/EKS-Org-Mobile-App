import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVehicleServicesUseCase extends BaseUseCase<ApiResult<List<VehicleServiceGroupEntity>>, GetVehicleServicesParamEntity> {
  GetVehicleServicesUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<VehicleServiceGroupEntity>>> call(GetVehicleServicesParamEntity arg) async {
    return await _repository.getVehicleServices(arg);
  }
}
