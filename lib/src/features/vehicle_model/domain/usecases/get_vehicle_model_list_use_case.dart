import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/repository/vehicle_model_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVehicleModelListUseCase
    extends BaseUseCase<ApiResult<VehicleModelPageEntity>,
        VehicleModelFilterParamEntity> {
  GetVehicleModelListUseCase(this._repository);

  final VehicleModelRepository _repository;

  @override
  Future<ApiResult<VehicleModelPageEntity>> call(
    VehicleModelFilterParamEntity arg,
  ) => _repository.getByFilter(arg);
}
