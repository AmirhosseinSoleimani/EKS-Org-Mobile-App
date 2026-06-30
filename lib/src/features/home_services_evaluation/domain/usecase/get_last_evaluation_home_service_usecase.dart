import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLastEvaluationHomeServiceUseCase
    extends
        BaseUseCase<
          ApiResult<EvaluationResponseEntity?>,
          LastEvaluationRequestEntity
        > {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  GetLastEvaluationHomeServiceUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<EvaluationResponseEntity?>> call(arg) async {
    ApiResult<EvaluationResponseEntity?> result = await _homeServiceRepository
        .getLastEvaluationHomeServices(arg);
    return result;
  }
}
