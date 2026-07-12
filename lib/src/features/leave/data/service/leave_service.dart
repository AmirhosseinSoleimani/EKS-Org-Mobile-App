import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_details_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_list_item_model.dart';
import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_reason_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'leave_service.g.dart';

@RestApi()
@lazySingleton
abstract class LeaveService {
  @factoryMethod
  factory LeaveService(Dio dio) = _LeaveService;

  @GET('/api/StaffLeave/GetLeaveReports')
  Future<BaseListResponse<LeaveListItemModel>> getLeaveReports(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/StaffLeave/GetStaffLeaveRequestById')
  Future<BaseSingleResponse<LeaveDetailsModel>> getStaffLeaveRequestById(
    @Query('id') int id,
  );

  @GET('/api/StaffLeave/GetReasons')
  Future<BaseListResponse<LeaveReasonModel>> getReasons();

  @POST('/api/StaffLeave/ChangeStaffRequestStatus')
  Future<BaseResponse> changeStaffRequestStatus(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/StaffLeave/RollbackStaffLeaveRequest')
  Future<BaseResponse> rollbackStaffLeaveRequest(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/AgencyInfo/GetAgencyByName')
  Future<BaseListResponse<LeaveListItemModel>> getAgencyByName(
    @Query('Title') String title,
  );
}

