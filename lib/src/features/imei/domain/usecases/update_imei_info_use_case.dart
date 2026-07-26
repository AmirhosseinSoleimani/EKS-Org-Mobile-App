import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_mutation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/repository/imei_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateImeiInfoUseCase
    extends BaseUseCase<ApiResult<String>, ImeiInfoMutationParamEntity> {
  UpdateImeiInfoUseCase(this._repository);

  final ImeiRepository _repository;

  @override
  Future<ApiResult<String>> call(ImeiInfoMutationParamEntity arg) {
    return _repository.update(arg);
  }
}
