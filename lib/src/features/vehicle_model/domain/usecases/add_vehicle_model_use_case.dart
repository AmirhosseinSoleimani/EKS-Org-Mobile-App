import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/repository/vehicle_model_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddVehicleModelUseCase
    extends BaseUseCase<ApiResult<String>, VehicleModelFormParamEntity> {
  AddVehicleModelUseCase(this._repository);

  final VehicleModelRepository _repository;

  @override
  Future<ApiResult<String>> call(VehicleModelFormParamEntity arg) =>
      _repository.addVehicleModel(arg);
}
