import 'package:eks_sana_plus_org/src/features/leave/data/data_sources/leave_data_source.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_details_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_list_item_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/params/change_leave_status_param_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/params/get_leave_reports_param_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/params/rollback_leave_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/service/leave_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LeaveDataSource)
class LeaveDataSourceImpl extends LeaveDataSource {
  LeaveDataSourceImpl(this._service);

  final LeaveService _service;

  @override
  Future<BaseListResponse<LeaveListItemModel>> getLeaveReports(
    GetLeaveReportsParamModel param,
  ) async {
    return _service.getLeaveReports(param.toQueryParameters());
  }

  @override
  Future<BaseSingleResponse<LeaveDetailsModel>> getLeaveDetails(int id) async {
    return _service.getStaffLeaveRequestById(id);
  }

  @override
  Future<BaseListResponse<LeaveReasonModel>> getReasons() async {
    return _service.getReasons();
  }

  @override
  Future<BaseResponse> changeStaffRequestStatus(
    ChangeLeaveStatusParamModel param,
  ) async {
    return _service.changeStaffRequestStatus(param.toJson());
  }

  @override
  Future<BaseResponse> rollbackStaffLeaveRequest(
    RollbackLeaveRequestParamModel param,
  ) async {
    return _service.rollbackStaffLeaveRequest(param.toJson());
  }

  @override
  Future<BaseResponse> deleteLeaveRequest(int id) async {
    return _service.deleteLeaveRequest(id);
  }
}
