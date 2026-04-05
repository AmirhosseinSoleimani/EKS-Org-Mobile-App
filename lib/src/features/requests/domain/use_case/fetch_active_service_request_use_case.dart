import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchActiveServiceRequestUseCase extends BaseUseCaseNoArgs {
  FetchActiveServiceRequestUseCase(this._repository);

  final RequestRepository _repository;

  @override
  Future<ApiResult<List<RequestEntity?>>> call() async {
    return await _repository.fetchActiveServiceRequestList();

  }
}
