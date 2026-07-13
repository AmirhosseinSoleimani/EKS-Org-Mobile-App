import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/rollback_leave_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/repositories/leave_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RollbackLeaveRequestUseCase
    extends BaseUseCase<ApiResult<void>, RollbackLeaveRequestParamEntity> {
  RollbackLeaveRequestUseCase(this._repository);

  final LeaveRepository _repository;

  @override
  Future<ApiResult<void>> call(arg) {
    return _repository.rollbackStaffLeaveRequest(arg);
  }
}

