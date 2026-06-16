
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class FetchInsertHomeServiceCategoryUseCase extends BaseUseCaseNoArgs {
  FetchInsertHomeServiceCategoryUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<List<InsertHomeServiceCategoryResponseEntity>?>> call() async {
    final result = await _repository.fetchHomeServiceCategories();
    return result;
  }
}
