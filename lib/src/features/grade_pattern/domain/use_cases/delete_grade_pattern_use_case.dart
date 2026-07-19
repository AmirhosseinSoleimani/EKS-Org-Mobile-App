import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/repositories/grade_pattern_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteGradePatternUseCase extends BaseUseCase<ApiResult<void>, int> {
  DeleteGradePatternUseCase(this._repository);

  final GradePatternRepository _repository;

  @override
  Future<ApiResult<void>> call(int arg) {
    return _repository.deleteById(arg);
  }
}
