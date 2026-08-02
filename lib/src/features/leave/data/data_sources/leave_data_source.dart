import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_details_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_list_item_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/params/change_leave_status_param_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/params/get_leave_reports_param_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/params/rollback_leave_request_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class LeaveDataSource {
  Future<BaseListResponse<LeaveListItemModel>> getLeaveReports(
    GetLeaveReportsParamModel param,
  );

  Future<BaseSingleResponse<LeaveDetailsModel>> getLeaveDetails(int id);

  Future<BaseListResponse<LeaveReasonModel>> getReasons();

  Future<BaseResponse> changeStaffRequestStatus(
    ChangeLeaveStatusParamModel param,
  );

  Future<BaseResponse> rollbackStaffLeaveRequest(
    RollbackLeaveRequestParamModel param,
  );

  Future<BaseResponse> deleteLeaveRequest(int id);
}
