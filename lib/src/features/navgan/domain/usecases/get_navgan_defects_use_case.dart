import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNavganDefectsUseCase extends BaseUseCase<
    ApiResult<List<NavganDefectEntity>>, NavganServiceCategoryParamEntity> {
  GetNavganDefectsUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<List<NavganDefectEntity>>> call(
    NavganServiceCategoryParamEntity arg,
  ) {
    return _repository.getDefects(arg);
  }
}
