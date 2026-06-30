import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAidServicesListUseCase
    extends BaseUseCase<ApiResult<ServiceResponseEntity>, ServicesParamEntity> {
  EvaluationRepository evaluationRepository;

  GetAidServicesListUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<ServiceResponseEntity>> call(ServicesParamEntity arg) async {
    return await evaluationRepository.getAidServices(arg);
  }
}
