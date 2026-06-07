import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLastEvaluationUseCase
    extends
        BaseUseCase<
          ApiResult<ResponseLastEvaluationEntity>,
          LastEvaluationParamEntity
        > {
  EvaluationRepository evaluationRepository;

  GetLastEvaluationUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<ResponseLastEvaluationEntity>> call(
    LastEvaluationParamEntity arg,
  ) async {
    return await evaluationRepository.getLastEvaluation(arg);
  }
}
