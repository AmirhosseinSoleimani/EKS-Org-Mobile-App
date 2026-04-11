import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetReliefRequestListUseCase extends BaseUseCaseNoArgs {
  final RequestRepository _repository;

  GetReliefRequestListUseCase(this._repository);

  @override
  Future<ApiResult<List<ReliefRequestEntity>>> call() async {
    return await _repository.getReliefRequestList();
  }
}
