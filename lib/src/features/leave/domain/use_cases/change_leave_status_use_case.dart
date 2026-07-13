import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/change_leave_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/repositories/leave_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangeLeaveStatusUseCase
    extends BaseUseCase<ApiResult<void>, ChangeLeaveStatusParamEntity> {
  ChangeLeaveStatusUseCase(this._repository);

  final LeaveRepository _repository;

  @override
  Future<ApiResult<void>> call(arg) {
    return _repository.changeStaffRequestStatus(arg);
  }
}

