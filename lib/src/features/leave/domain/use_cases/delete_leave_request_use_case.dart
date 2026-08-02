import 'package:eks_sana_plus_org/src/features/leave/domain/repositories/leave_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteLeaveRequestUseCase extends BaseUseCase<ApiResult<void>, int> {
  DeleteLeaveRequestUseCase(this._repository);

  final LeaveRepository _repository;

  @override
  Future<ApiResult<void>> call(int arg) {
    return _repository.deleteLeaveRequest(arg);
  }
}
