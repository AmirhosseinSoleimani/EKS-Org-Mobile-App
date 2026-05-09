import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/accept_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AcceptEvaluationUseCase
    extends
        BaseUseCase<
          ApiResult<AcceptEvaluationResponseEntity>,
          AcceptEvaluationParamEntity
        > {
  EvaluationRepository evaluationRepository;

  AcceptEvaluationUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<AcceptEvaluationResponseEntity>> call(
    AcceptEvaluationParamEntity arg,
  ) async {
    return await evaluationRepository.acceptEvaluation(arg);
  }
}
