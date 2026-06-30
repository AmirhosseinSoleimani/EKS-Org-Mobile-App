import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRequestControlInfoUseCase extends BaseUseCase<
    ApiResult<ControlInfoEntity>, ServiceRequestParamEntity> {
  final RequestRepository _repository;

  GetRequestControlInfoUseCase(this._repository);

  @override
  Future<ApiResult<ControlInfoEntity>> call(arg) async {
    return await _repository.getControlInfo(arg);
  }
}
