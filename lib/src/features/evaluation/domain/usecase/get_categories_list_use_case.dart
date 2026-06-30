import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesListUseCase
    extends
        BaseUseCase<
          ApiResult<List<ServiceCategoryEntity>>,
          CategoryParamEntity
        > {
  EvaluationRepository evaluationRepository;

  GetCategoriesListUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<List<ServiceCategoryEntity>>> call(
    CategoryParamEntity arg,
  ) async {
    return await evaluationRepository.getServiceCategoryList(arg);
  }
}
