import 'package:eks_sana_plus_org/src/features/services/domain/entities/follow_up_status_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetFollowUpStatusTypeListUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<FollowUpStatusTypeEntity>>> {
  final RequestRepository _repository;

  GetFollowUpStatusTypeListUseCase(this._repository);

  @override
  Future<ApiResult<List<FollowUpStatusTypeEntity>>> call() async {
    return await _repository.getFollowUpStatusTypes();
  }
}
