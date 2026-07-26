import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/repository/imei_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetImeiInfoByIdUseCase
    extends BaseUseCase<ApiResult<ImeiInfoEntity>, ImeiInfoIdParamEntity> {
  GetImeiInfoByIdUseCase(this._repository);

  final ImeiRepository _repository;

  @override
  Future<ApiResult<ImeiInfoEntity>> call(ImeiInfoIdParamEntity arg) {
    return _repository.getById(arg);
  }
}
