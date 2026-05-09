import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServiceDetailEvaluationUseCase
    extends
        BaseUseCase<
          ApiResult<EmdadgarServiceDetailEntity>,
          ServiceDetailForEvaluationParamEntity
        > {
  EvaluationRepository evaluationRepository;

  GetServiceDetailEvaluationUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<EmdadgarServiceDetailEntity>> call(
    ServiceDetailForEvaluationParamEntity arg,
  ) async {
    return await evaluationRepository
        .getServiceDetailAndCheckSubscriptionForEmdagar(arg);
  }
}
