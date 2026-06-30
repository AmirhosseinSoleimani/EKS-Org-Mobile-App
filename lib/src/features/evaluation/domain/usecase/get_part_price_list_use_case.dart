import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_price_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPartPriceUseCase
    extends
        BaseUseCase<ApiResult<PartPriceEntity>, PartPriceParamEntity> {
  EvaluationRepository evaluationRepository;

  GetPartPriceUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<PartPriceEntity>> call(
    PartPriceParamEntity arg,
  ) async {
    return await evaluationRepository.getPartPrice(arg);
  }
}
