import 'package:eks_sana_plus_org/src/features/leave/data/models/params/change_leave_status_param_model.dart';

class ChangeLeaveStatusParamEntity {
  const ChangeLeaveStatusParamEntity({
    required this.leaveRequestId,
    required this.status,
    this.description = '',
  });

  final int leaveRequestId;
  final int status;
  final String description;

  ChangeLeaveStatusParamModel toModel() {
    return ChangeLeaveStatusParamModel(
      leaveRequestId: leaveRequestId,
      status: status,
      description: description,
    );
  }
}

