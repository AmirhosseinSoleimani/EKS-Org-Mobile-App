import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/repository/imei_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetImeiInfoListUseCase
    extends BaseUseCase<ApiResult<ImeiInfoPageEntity>, ImeiInfoFilterParamEntity> {
  GetImeiInfoListUseCase(this._repository);

  final ImeiRepository _repository;

  @override
  Future<ApiResult<ImeiInfoPageEntity>> call(ImeiInfoFilterParamEntity arg) {
    return _repository.getByFilter(arg);
  }
}
