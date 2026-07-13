import 'package:eks_sana_plus_org/src/features/leave/data/data_sources/leave_data_source.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_details_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/change_leave_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/get_leave_reports_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/rollback_leave_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/repositories/leave_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LeaveRepository)
class LeaveRepositoryImpl extends LeaveRepository {
  LeaveRepositoryImpl(this._dataSource);

  final LeaveDataSource _dataSource;

  @override
  Future<ApiResult<List<LeaveListItemEntity>>> getLeaveReports(
    GetLeaveReportsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getLeaveReports(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<LeaveDetailsEntity>> getLeaveDetails(int id) async {
    try {
      final result = await _dataSource.getLeaveDetails(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LeaveReasonEntity>>> getReasons() async {
    try {
      final result = await _dataSource.getReasons();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> changeStaffRequestStatus(
    ChangeLeaveStatusParamEntity param,
  ) async {
    try {
      final response =
          await _dataSource.changeStaffRequestStatus(param.toModel());
      if (response.resultCode == 0) {
        return const ApiResult.success(data: null);
      }
      return ApiResult.failure(
        failures: response.failures?.join('\n') ??
            'تغییر وضعیت مرخصی با خطا مواجه شد.',
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> rollbackStaffLeaveRequest(
    RollbackLeaveRequestParamEntity param,
  ) async {
    try {
      final response =
          await _dataSource.rollbackStaffLeaveRequest(param.toModel());
      if (response.resultCode == 0) {
        return const ApiResult.success(data: null);
      }
      return ApiResult.failure(
        failures: response.failures?.join('\n') ??
            'بازگشت وضعیت مرخصی با خطا مواجه شد.',
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}

