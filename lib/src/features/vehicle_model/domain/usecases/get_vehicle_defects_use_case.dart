import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/repository/vehicle_model_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetVehicleDefectsUseCase
    extends BaseUseCase<ApiResult<List<VehicleDefectEntity>>,
        VehicleModelServiceCategoryParamEntity> {
  GetVehicleDefectsUseCase(this._repository);

  final VehicleModelRepository _repository;

  @override
  Future<ApiResult<List<VehicleDefectEntity>>> call(
    VehicleModelServiceCategoryParamEntity arg,
  ) => _repository.getDefects(arg);
}
