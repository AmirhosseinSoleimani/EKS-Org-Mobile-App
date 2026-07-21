import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class GradePatternRepository {
  Future<ApiResult<GradePatternPageEntity>> getByFilter(
    GradePatternFilterParamEntity param,
  );

  Future<ApiResult<GradePatternEntity>> getById(int id);

  Future<ApiResult<GradePatternEntity>> create(GradePatternEntity param);

  Future<ApiResult<GradePatternEntity>> update(GradePatternEntity param);

  Future<ApiResult<void>> deleteById(int id);

  Future<ApiResult<List<GradePatternReferenceEntity>>> getReferences({
    required int refId,
  });

  Future<ApiResult<void>> assignReference(GradePatternReferenceParamEntity param);

  Future<ApiResult<void>> deleteReferenceById(int id);
}
