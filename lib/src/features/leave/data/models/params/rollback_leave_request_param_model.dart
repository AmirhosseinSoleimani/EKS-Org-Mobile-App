import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/rollback_leave_request_param_entity.dart';

class RollbackLeaveRequestParamModel extends RollbackLeaveRequestParamEntity {
  const RollbackLeaveRequestParamModel({
    required super.leaveRequestId,
  });

  Map<String, dynamic> toJson() {
    return {
      'LeaveRequestId': leaveRequestId,
    };
  }
}

