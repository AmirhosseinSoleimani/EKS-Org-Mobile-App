import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPartUseCase
    extends
        BaseUseCase<ApiResult<List<PartResponseEntity?>>, PartRequestEntity?> {
  GetPartUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<List<PartResponseEntity?>>> call(arg) async {
    final result = await _repository.getParts(arg);
    return result;
  }
}
