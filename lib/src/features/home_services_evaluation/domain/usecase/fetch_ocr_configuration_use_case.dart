import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchOcrConfigurationUseCase
    extends
        BaseUseCase<
          ApiResult<OcrConfigurationKilometerResponseEntity?>,
          OcrConfigurationKilometerRequestEntity?
        > {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  FetchOcrConfigurationUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<OcrConfigurationKilometerResponseEntity?>> call(arg) async {
    final result = await _homeServiceRepository.fetchOcrConfiguration(arg);
    return result;
  }
}
