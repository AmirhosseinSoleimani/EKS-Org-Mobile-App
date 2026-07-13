import 'package:eks_sana_plus_org/src/features/vehicle_info/data/data_sources/vehicle_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_defect_limitation_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_model_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_tool_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/services/vehicle_info_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VehicleInfoDataSource)
class VehicleInfoDataSourceImpl extends VehicleInfoDataSource {
  VehicleInfoDataSourceImpl(this._service);

  final VehicleInfoService _service;

  @override
  Future<VehicleInfoPageModel> getVehicles(VehicleInfoFilterRequestModel request) => _service.getVehicles(request);
  @override
  Future<BaseSingleResponse<VehicleInfoModel>> getVehicleById(int id) => _service.getVehicleById(id);
  @override
  Future<BaseResponse> createVehicle(Map<String, dynamic> body) => _service.createVehicle(body);
  @override
  Future<BaseResponse> editVehicle(Map<String, dynamic> body) => _service.editVehicle(body);
  @override
  Future<BaseResponse> deleteVehicle(int id) => _service.deleteVehicle(id);
  @override
  Future<VehicleModelPageModel> getVehicleModels(VehicleInfoFilterRequestModel request) => _service.getVehicleModels(request);
  @override
  Future<BaseListResponse<EmdadServiceCategoryGroupModel>> getServiceCategories(int id) => _service.getServiceCategories(id);
  @override
  Future<BaseResponse> submitServiceCategories(Map<String, dynamic> body) => _service.submitServiceCategories(body);
  @override
  Future<BaseListResponse<VehicleToolModel>> getVehicleTools(Map<String, dynamic> body) => _service.getVehicleTools(body);
  @override
  Future<BaseResponse> submitVehicleTools(Map<String, dynamic> body) => _service.submitVehicleTools(body);
  @override
  Future<BaseListResponse<EmdadServiceCategoryGroupModel>> getGroupedServiceCategories(int id) => _service.getGroupedServiceCategories(id);
  @override
  Future<BaseResponse> insertBatchServiceCategories(Map<String, dynamic> body) => _service.insertBatchServiceCategories(body);
  @override
  Future<BaseListResponse<VehicleDefectLimitationModel>> getDefects(Map<String, dynamic> body) => _service.getDefects(body);
  @override
  Future<BaseResponse> submitDefectLimitation(Map<String, dynamic> body) => _service.submitDefectLimitation(body);
}
