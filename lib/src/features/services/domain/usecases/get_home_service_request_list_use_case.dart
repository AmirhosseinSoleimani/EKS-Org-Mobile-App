import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHomeServiceRequestListUseCase extends BaseUseCaseNoArgs {
  final RequestRepository _repository;

  GetHomeServiceRequestListUseCase(this._repository);

  @override
  Future<ApiResult<List<HomeServiceRequestEntity>>> call() async {
    return await _repository.getHomeServiceRequestList();
  }
}
