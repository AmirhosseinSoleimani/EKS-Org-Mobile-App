import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetGradePatternReferencesUseCase extends BaseUseCase<
    ApiResult<List<GradePatternReferenceEntity>>, NavganIdParamEntity> {
  GetGradePatternReferencesUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<List<GradePatternReferenceEntity>>> call(
    NavganIdParamEntity arg,
  ) {
    return _repository.getGradePatternReferences(arg);
  }
}
