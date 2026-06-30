import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_price_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetReusablePriceUseCase
    extends
        BaseUseCase<
          ApiResult<ReusablePriceResponseEntity?>,
          PartPriceRequestEntity?
        > {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  GetReusablePriceUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<ReusablePriceResponseEntity?>> call(arg) async {
    ApiResult<ReusablePriceResponseEntity?> result =
        await _homeServiceRepository.getReusablePrice(arg);
    return result;
  }
}
