import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServiceCategoriesUseCase
    extends
    BaseUseCase<
        ApiResult<List<ServiceCategoryResponseEntity?>>,
        ServiceCategoryRequestEntity
    > {
  GetServiceCategoriesUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<List<ServiceCategoryResponseEntity?>>> call(arg) async {
    return await _repository.getServiceCategories(arg);
  }
}