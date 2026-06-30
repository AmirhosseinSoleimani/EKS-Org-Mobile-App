import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLastEvaluationUseCase extends BaseUseCaseNoArgs {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  GetLastEvaluationUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<LastEvaluationEntity?>> call() async {
    final result = await _homeServiceRepository.getLastEvaluation();
    return result;
  }
}
