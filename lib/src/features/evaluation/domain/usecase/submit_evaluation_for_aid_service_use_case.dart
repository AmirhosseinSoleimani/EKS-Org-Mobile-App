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
  SubmitEvaluationForAidServiceUseCase(this.evaluationRepository);

  final EvaluationRepository evaluationRepository;

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> call(
    AidServiceEvaluationSubmitParamEntity arg,
  ) async {
    return evaluationRepository.submitEvaluationForAidService(arg);
  }

  Future<ApiResult<PostEvaluationResponseEntity>> hesabdari(
    AidServiceEvaluationSubmitParamEntity arg,
  ) async {
    return evaluationRepository.submitHesabdariEvaluation(arg);
  }

  Future<ApiResult<PostEvaluationResponseEntity>> daraei(
    AidServiceEvaluationSubmitParamEntity arg,
  ) async {
    return evaluationRepository.submitDaraeiEvaluation(arg);
  }

  Future<ApiResult<PostEvaluationResponseEntity>> customerCorrection(
    AidServiceEvaluationSubmitParamEntity arg,
  ) async {
    return evaluationRepository.submitTrackerEvaluation(arg);
  }

  Future<ApiResult<PostEvaluationResponseEntity>> emdadgarCorrection(
    AidServiceEvaluationSubmitParamEntity arg,
  ) async {
    return evaluationRepository.submitInvoiceOperatorEvaluation(arg);
  }
}
