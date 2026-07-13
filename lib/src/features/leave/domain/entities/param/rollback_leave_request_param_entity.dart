import 'package:eks_sana_plus_org/src/features/leave/data/models/params/rollback_leave_request_param_model.dart';

class RollbackLeaveRequestParamEntity {
  const RollbackLeaveRequestParamEntity({
    required this.leaveRequestId,
  });

  final int leaveRequestId;

  RollbackLeaveRequestParamModel toModel() {
    return RollbackLeaveRequestParamModel(
      leaveRequestId: leaveRequestId,
    );
  }
}

