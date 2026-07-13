import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/repositories/grade_pattern_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetGradePatternListUseCase
    extends BaseUseCase<ApiResult<GradePatternPageEntity>, GradePatternFilterParamEntity> {
  GetGradePatternListUseCase(this._repository);

  final GradePatternRepository _repository;

  @override
  Future<ApiResult<GradePatternPageEntity>> call(
    GradePatternFilterParamEntity arg,
  ) {
    return _repository.getByFilter(arg);
  }
}
