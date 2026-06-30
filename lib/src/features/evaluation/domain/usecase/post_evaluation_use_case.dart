import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostEvaluationUseCase
    extends
        BaseUseCase<
          ApiResult<PostEvaluationResponseEntity>,
          ServiceEvaluationParamEntity
        > {
  EvaluationRepository evaluationRepository;

  PostEvaluationUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> call(
    ServiceEvaluationParamEntity arg,
  ) async {
    return await evaluationRepository.postEvaluation(arg);
  }
}
