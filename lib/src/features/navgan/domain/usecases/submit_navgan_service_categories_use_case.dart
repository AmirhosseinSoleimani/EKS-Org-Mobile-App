import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitNavganServiceCategoriesUseCase
    extends BaseUseCase<ApiResult<String>, NavganIdsPayloadParamEntity> {
  SubmitNavganServiceCategoriesUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<String>> call(NavganIdsPayloadParamEntity arg) {
    return _repository.submitServiceCategories(arg);
  }
}
