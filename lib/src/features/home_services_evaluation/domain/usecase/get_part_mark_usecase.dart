import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPartMarkHomeServiceUseCase
    extends
        BaseUseCase<
          ApiResult<List<PartMarkResponseEntity?>>,
          PartMarkRequestEntity?
        > {
  final HomeServiceEvaluationRepository _homeServiceRepository;

  GetPartMarkHomeServiceUseCase(this._homeServiceRepository);

  @override
  Future<ApiResult<List<PartMarkResponseEntity?>>> call(arg) async {
    ApiResult<List<PartMarkResponseEntity?>> result =
        await _homeServiceRepository.getPartMarks(arg);
    return result;
  }
}
