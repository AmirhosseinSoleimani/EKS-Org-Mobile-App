import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entiteis/urgent_request_entity.dart';
import '../repositories/main_repository.dart';

@lazySingleton
class UrgentRequestUseCase
    extends BaseUseCaseNoArgs<ApiResult<UrgentRequestEntity>> {
  UrgentRequestUseCase(this._repository);

  final MainRepository _repository;

  @override
  Future<ApiResult<UrgentRequestEntity>> call() async {
    final result = await _repository.sendUrgentRequest();
    return result;
  }
}
