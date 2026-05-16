import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_followups_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_emdadgar_followups_data_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEmdadgarFollowupsDataUseCase
    extends
        BaseUseCase<
          ApiResult<EmdadgarFollowupsDataEntity>,
          GetEmdadgarFollowupsDataParamEntity
        > {
  final RequestRepository _repository;

  GetEmdadgarFollowupsDataUseCase(this._repository);

  @override
  Future<ApiResult<EmdadgarFollowupsDataEntity>> call(
    GetEmdadgarFollowupsDataParamEntity arg,
  ) async {
    return await _repository.getEmdadgarFollowupsData(arg);
  }
}
