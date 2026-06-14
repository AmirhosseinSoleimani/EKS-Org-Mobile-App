import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchKilometerFromImageUseCase
    extends
        BaseUseCase<
          ApiResult<KilometerFromImageResponseEntity?>,
          KilometerFromImageRequestEntity?
        > {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  FetchKilometerFromImageUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<KilometerFromImageResponseEntity?>> call(arg) async {
    final result = await _homeServiceRepository.fetchKilometerImage(arg);
    return result;
  }
}
