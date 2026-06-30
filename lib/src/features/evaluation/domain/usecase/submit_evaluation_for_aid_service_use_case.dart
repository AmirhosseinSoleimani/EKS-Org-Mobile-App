import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/aid_service_evaluation_submit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubmitEvaluationForAidServiceUseCase
    extends
        BaseUseCase<
          ApiResult<PostEvaluationResponseEntity>,
          AidServiceEvaluationSubmitParamEntity
        > {
  EvaluationRepository evaluationRepository;

  SubmitEvaluationForAidServiceUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> call(
    AidServiceEvaluationSubmitParamEntity arg,
  ) async {
    return await evaluationRepository.submitEvaluationForAidService(arg);
  }
}
