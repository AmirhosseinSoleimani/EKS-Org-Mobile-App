import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServicesUseCase
    extends
        BaseUseCase<ApiResult<ServiceResponseEntity?>, ServiceRequestEntity?> {
  GetServicesUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<ServiceResponseEntity?>> call(arg) async {
    final result = await _repository.getServices(arg);
    return result;
  }
}
