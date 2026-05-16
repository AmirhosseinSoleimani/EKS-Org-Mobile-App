import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEmdadgarInfoUseCase extends BaseUseCase<ApiResult<EmdadgarInfoEntity?>,
    ServiceRequestParamEntity> {
  final RequestRepository _repository;

  GetEmdadgarInfoUseCase(this._repository);

  @override
  Future<ApiResult<EmdadgarInfoEntity?>> call(arg) async {
    return await _repository.getEmdadgarInfo(arg);
  }
}
