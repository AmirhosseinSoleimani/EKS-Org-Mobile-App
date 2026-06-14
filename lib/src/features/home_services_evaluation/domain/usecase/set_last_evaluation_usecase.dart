import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetLastEvaluationUseCase
    extends BaseUseCase<ApiResult<String?>, LastEvaluationEntity?> {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  SetLastEvaluationUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<String?>> call(arg) async {
    final result = await _homeServiceRepository.setLastEvaluation(arg);
    return result;
  }
}
