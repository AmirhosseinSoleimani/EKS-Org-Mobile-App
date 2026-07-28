import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetGradePatternListUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<GradePatternEntity>>> {
  GetGradePatternListUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<List<GradePatternEntity>>> call() {
    return _repository.getGradePatterns();
  }
}
