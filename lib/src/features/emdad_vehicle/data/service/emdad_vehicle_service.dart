import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/emdad_vehicle_info_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/imei_info_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/submit_vehicle_services_response_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/submit_vehicle_tools_response_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_history_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_id_response_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_service_group_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_tool_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'emdad_vehicle_service.g.dart';

@RestApi()
@lazySingleton
abstract class EmdadVehicleService {
  @factoryMethod
  factory EmdadVehicleService(Dio dio) = _EmdadVehicleService;

  @POST('/api/VehicleModel/GetByFilterJson')
  Future<BaseListResponse<VehicleModelModel>> getEmdadVehicleList(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/VehicleInfo/GetVehicleTools')
  Future<BaseListResponse<VehicleToolModel>> getVehicleTools(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/VehicleInfo/SubmitVehicleTools')
  Future<BaseSingleResponse<SubmitVehicleToolsResponseModel>>
      submitVehicleTools(@Body() Map<String, dynamic> body);

  @GET('/api/VehicleInfo/GetEmdadServiceCategoryGroupingByServiceTypeTitleSelctedForVehicleInfoId')
  Future<BaseListResponse<VehicleServiceGroupModel>> getVehicleServices(
    @Queries() Map<String, dynamic> query,
  );

  @POST('/api/VehicleInfo/GetDefectsByVehicleInfoIdAndServiceCategoryId')
  Future<BaseListResponse<VehicleDefectModel>> getVehicleDefects(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/VehicleInfo/SubmitVehicleInfoDefectLimitation')
  Future<void> submitVehicleDefectLimitation(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/VehicleInfo/InsertBatchEmdadServiceCategoriesByVehicleInfoId')
  Future<BaseSingleResponse<SubmitVehicleServicesResponseModel>>
      submitVehicleServices(@Body() Map<String, dynamic> body);

  @DELETE('/api/VehicleInfo/DeleteByID')
  Future<BaseSingleResponse<VehicleIdResponseModel>> deleteEmdadVehicle(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/SanHistory/GetSanLogHistoriesById')
  Future<BaseListResponse<VehicleHistoryModel>> getVehicleHistory(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/IMEIInfo/GetImei')
  Future<BaseListResponse<ImeiInfoModel>> getImeiList();

  @POST('/api/VehicleModel/GetByFilterJson')
  Future<BaseListResponse<VehicleModelModel>> getActiveVehicleModels(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/VehicleInfo/GetById')
  Future<BaseSingleResponse<EmdadVehicleInfoModel>> getEmdadVehicleById(
    @Queries() Map<String, dynamic> query,
  );

  @PUT('/api/VehicleInfo/put')
  Future<BaseSingleResponse<VehicleIdResponseModel>> updateEmdadVehicle(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/VehicleInfo/post')
  Future<BaseSingleResponse<VehicleIdResponseModel>> createEmdadVehicle(
    @Body() Map<String, dynamic> body,
  );
}
