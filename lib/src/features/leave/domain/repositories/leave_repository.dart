import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_details_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/change_leave_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/get_leave_reports_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/rollback_leave_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class LeaveRepository {
  Future<ApiResult<List<LeaveListItemEntity>>> getLeaveReports(
    GetLeaveReportsParamEntity param,
  );

  Future<ApiResult<LeaveDetailsEntity>> getLeaveDetails(int id);

  Future<ApiResult<List<LeaveReasonEntity>>> getReasons();

  Future<ApiResult<void>> changeStaffRequestStatus(
    ChangeLeaveStatusParamEntity param,
  );

  Future<ApiResult<void>> rollbackStaffLeaveRequest(
    RollbackLeaveRequestParamEntity param,
  );
}

