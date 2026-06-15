
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetInsertHomeServicePackageUseCase extends BaseUseCase<ApiResult<List<HomeServicePackageResponseEntity?>>, HomeServicePackageRequestEntity?> {
  GetInsertHomeServicePackageUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<List<HomeServicePackageResponseEntity?>>> call(arg) async {
    final result = await _repository.getHomeServicePackage(arg);
    return result;
  }
}
