import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/repositories/grade_pattern_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetGradePatternReferencesUseCase {
  GetGradePatternReferencesUseCase(this._repository);

  final GradePatternRepository _repository;

  Future<ApiResult<List<GradePatternReferenceEntity>>> call({
    required int refId,
  }) {
    return _repository.getReferences(refId: refId);
  }
}
