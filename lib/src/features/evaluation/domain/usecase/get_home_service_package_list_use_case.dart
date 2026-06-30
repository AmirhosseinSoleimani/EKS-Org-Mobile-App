import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/home_service_package_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_package_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHomeServicePackageListUseCase
    extends
        BaseUseCase<
          ApiResult<List<ServicePackageEntity>>,
          HomeServicePackageParamEntity
        > {
  EvaluationRepository evaluationRepository;

  GetHomeServicePackageListUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<List<ServicePackageEntity>>> call(
    HomeServicePackageParamEntity arg,
  ) async {
    return await evaluationRepository.getHomeServicePackage(arg);
  }
}
