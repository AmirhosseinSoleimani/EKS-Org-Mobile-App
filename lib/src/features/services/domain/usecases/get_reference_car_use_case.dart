import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_reference_car_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/reference_car_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetReferenceCarUseCase
    extends
        BaseUseCase<ApiResult<ReferenceCarEntity>, GetReferenceCarParamEntity> {
  final RequestRepository _repository;

  GetReferenceCarUseCase(this._repository);

  @override
  Future<ApiResult<ReferenceCarEntity>> call(
    GetReferenceCarParamEntity arg,
  ) async {
    return await _repository.getReferenceCar(arg);
  }
}
