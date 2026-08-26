import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_defect_limitation_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_history_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_model_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_tool_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class VehicleInfoDataSource {
  Future<BaseSingleResponse<VehicleInfoPageModel>> getVehicles(VehicleInfoFilterRequestModel request);
  Future<BaseSingleResponse<VehicleInfoModel>> getVehicleById(int id);
  Future<BaseResponse> createVehicle(Map<String, dynamic> body);
  Future<BaseResponse> editVehicle(Map<String, dynamic> body);
  Future<BaseResponse> deleteVehicle(int id);
  Future<BaseSingleResponse<VehicleModelPageModel>> getVehicleModels(VehicleInfoFilterRequestModel request);
  Future<BaseListResponse<EmdadServiceCategoryGroupModel>> getServiceCategories(int id);
  Future<BaseResponse> submitServiceCategories(Map<String, dynamic> body);
  Future<BaseListResponse<VehicleToolModel>> getVehicleTools(Map<String, dynamic> body);
  Future<BaseResponse> submitVehicleTools(Map<String, dynamic> body);
  Future<BaseListResponse<EmdadServiceCategoryGroupModel>> getGroupedServiceCategories(int id);
  Future<BaseResponse> insertBatchServiceCategories(Map<String, dynamic> body);
  Future<BaseListResponse<VehicleDefectLimitationModel>> getDefects(Map<String, dynamic> body);
  Future<BaseResponse> submitDefectLimitation(Map<String, dynamic> body);
  Future<BaseListResponse<VehicleHistoryModel>> getVehicleHistories(Map<String, dynamic> queryParameters);
}
