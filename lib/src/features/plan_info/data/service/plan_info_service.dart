import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_cancelation_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_info_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_lookup_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'plan_info_service.g.dart';

@RestApi()
@lazySingleton
abstract class PlanInfoService {
  @factoryMethod
  factory PlanInfoService(Dio dio) = _PlanInfoService;

  @POST('/api/Plan/GetByFilterJson')
  Future<BaseSingleResponse<PlanInfoListModel>> getPlans(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/Plan/GetById')
  Future<BaseSingleResponse<PlanInfoModel>> getPlanById(
    @Queries() Map<String, dynamic> query,
  );

  @POST('/api/Plan/post')
  Future<BaseSingleResponse<void>> createPlan(
    @Body() Map<String, dynamic> body,
  );

  @PUT('/api/Plan/put')
  Future<BaseSingleResponse<void>> editPlan(
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/api/Plan/DeleteByID')
  Future<BaseSingleResponse<void>> deletePlan(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/Plan/GetReasonsForChangeStatus')
  Future<BaseListResponse<PlanLookupModel>> getStatusReasons(
    @Queries() Map<String, dynamic> query,
  );

  @POST('/api/Plan/ChangeStatus')
  Future<BaseSingleResponse<void>> changeStatus(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/Plan/GetPlanInfoReport')
  Future<BaseListResponse<PlanInfoModel>> getPlanReport(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/Plan/CancelAllAssignedRequest')
  Future<BaseSingleResponse<PlanCancelationModel>> cancelAllAssignedRequest(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/EmdadUnit/GetByFilterJson')
  Future<BaseSingleResponse<PlanLookupListModel>> getEmdadUnits(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/Shift/GetByFilterJson')
  Future<BaseSingleResponse<PlanLookupListModel>> getShifts(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/SpecialPlan/GetByFilterJson')
  Future<BaseSingleResponse<PlanLookupListModel>> getSpecialPlans(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/Location/GetByFilterJson')
  Future<BaseSingleResponse<PlanLookupListModel>> getLocations(
    @Body() Map<String, dynamic> body,
  );
}
