import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/repository/imei_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteImeiInfoUseCase
    extends BaseUseCase<ApiResult<String>, ImeiInfoIdParamEntity> {
  DeleteImeiInfoUseCase(this._repository);

  final ImeiRepository _repository;

  @override
  Future<ApiResult<String>> call(ImeiInfoIdParamEntity arg) {
    return _repository.delete(arg);
  }
}
