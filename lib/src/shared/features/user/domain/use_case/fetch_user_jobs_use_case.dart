import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/job_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchUserJobsUseCase extends BaseUseCaseNoArgs {
  FetchUserJobsUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<ApiResult<List<JobResponseEntity>?>> call() async {
    final result = await _repository.fetchUserJobs();
    return result;
  }
}
