import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDistanceToCustomerHomeServiceUseCase
    extends
        BaseUseCase<
          ApiResult<DistanceToCustomerResponseEntity?>,
          DistanceToCustomerRequestEntity
        > {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  GetDistanceToCustomerHomeServiceUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<DistanceToCustomerResponseEntity?>> call(arg) async {
    final result = await _homeServiceRepository
        .getDistanceToCustomerHomeServices(arg);
    return result;
  }
}
