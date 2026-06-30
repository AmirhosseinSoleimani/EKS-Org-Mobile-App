import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/emdadgar_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEmdadgarListUseCase
    extends BaseUseCase<ApiResult<List<EmdadgarEntity>>, EmdadgarListParamEntity> {
  final RequestRepository _repository;

  GetEmdadgarListUseCase(this._repository);

  @override
  Future<ApiResult<List<EmdadgarEntity>>> call(EmdadgarListParamEntity arg) async {
    return await _repository.getEmdadgarList(arg);
  }
}
