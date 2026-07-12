import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/change_leave_status_param_entity.dart';

class ChangeLeaveStatusParamModel extends ChangeLeaveStatusParamEntity {
  const ChangeLeaveStatusParamModel({
    required super.leaveRequestId,
    required super.status,
    super.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'leaveRequestId': leaveRequestId,
      'status': status,
      'description': description,
    };
  }
}

