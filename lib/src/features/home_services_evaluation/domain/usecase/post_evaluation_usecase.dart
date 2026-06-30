import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_post_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostEvaluationUseCase
    extends
        BaseUseCase<
          ApiResult<EvaluationPostResponseEntity?>,
          LastEvaluationEntity?
        > {
  PostEvaluationUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<EvaluationPostResponseEntity?>> call(arg) async {
    final result = await _repository.postEvaluation(arg);
    return result;
  }
}
