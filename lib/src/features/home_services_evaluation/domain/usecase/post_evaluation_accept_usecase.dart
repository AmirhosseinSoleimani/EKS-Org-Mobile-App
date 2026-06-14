import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/emdadgar_evaluation_accept_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostEvaluationAcceptUseCase extends BaseUseCase {
  final HomeServiceEvaluationRepository _repository;

  PostEvaluationAcceptUseCase(this._repository);

  @override
  Future<ApiResult<EmdadgarEvaluationAcceptResponseEntity?>> call(arg) async {
    ApiResult<EmdadgarEvaluationAcceptResponseEntity?> result =
        await _repository.emdadgarEvaluationAccept(arg);
    return result;
  }
}
