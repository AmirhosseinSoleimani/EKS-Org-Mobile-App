import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_defect_limitation_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_history_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_model_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_tool_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VehicleInfoService {
  VehicleInfoService(this._dio);

  final Dio _dio;

  Future<VehicleInfoPageModel> getVehicles(VehicleInfoFilterRequestModel request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/GetByFilterJson',
      data: request.toJson(),
    );
    return VehicleInfoPageModel.fromJson(response.data ?? {});
  }

  Future<BaseSingleResponse<VehicleInfoModel>> getVehicleById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/VehicleInfo/GetById',
      queryParameters: {'Id': id},
    );
    return BaseSingleResponse<VehicleInfoModel>.fromJson(
      response.data ?? {},
      VehicleInfoModel.fromJson,
    );
  }

  Future<BaseResponse> createVehicle(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>('/api/VehicleInfo/post', data: body);
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseResponse> editVehicle(Map<String, dynamic> body) async {
    final response = await _dio.put<Map<String, dynamic>>('/api/VehicleInfo/put', data: body);
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseResponse> deleteVehicle(int id) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/api/VehicleInfo/DeleteByID',
      queryParameters: {'id': id},
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<VehicleModelPageModel> getVehicleModels(VehicleInfoFilterRequestModel request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleModel/GetByFilterJson',
      data: request.toJson(),
    );
    return VehicleModelPageModel.fromJson(response.data ?? {});
  }

  Future<BaseListResponse<EmdadServiceCategoryGroupModel>> getServiceCategories(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/VehicleInfo/GetServiceCategories',
      queryParameters: {'id': id},
    );
    return BaseListResponse<EmdadServiceCategoryGroupModel>.fromJson(
      response.data ?? {},
      EmdadServiceCategoryGroupModel.fromJson,
    );
  }

  Future<BaseResponse> submitServiceCategories(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/SubmitServiceCategories',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseListResponse<VehicleToolModel>> getVehicleTools(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/GetVehicleTools',
      data: body,
    );
    return BaseListResponse<VehicleToolModel>.fromJson(
      response.data ?? {},
      VehicleToolModel.fromJson,
    );
  }

  Future<BaseResponse> submitVehicleTools(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/SubmitVehicleTools',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseListResponse<EmdadServiceCategoryGroupModel>> getGroupedServiceCategories(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/VehicleInfo/GetEmdadServiceCategoryGroupingByServiceTypeTitleSelctedForVehicleInfoId',
      queryParameters: {'id': id},
    );
    return BaseListResponse<EmdadServiceCategoryGroupModel>.fromJson(
      response.data ?? {},
      EmdadServiceCategoryGroupModel.fromJson,
    );
  }

  Future<BaseResponse> insertBatchServiceCategories(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/InsertBatchEmdadServiceCategoriesByVehicleInfoId',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseListResponse<VehicleDefectLimitationModel>> getDefects(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/GetDefectsByVehicleInfoIdAndServiceCategoryId',
      data: body,
    );
    return BaseListResponse<VehicleDefectLimitationModel>.fromJson(
      response.data ?? {},
      VehicleDefectLimitationModel.fromJson,
    );
  }

  Future<BaseResponse> submitDefectLimitation(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/VehicleInfo/SubmitVehicleInfoDefectLimitation',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseListResponse<VehicleHistoryModel>> getVehicleHistories(Map<String, dynamic> queryParameters) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/SanHistory/GetSanLogHistoriesById',
      queryParameters: queryParameters,
    );
    return BaseListResponse<VehicleHistoryModel>.fromJson(
      response.data ?? {},
      VehicleHistoryModel.fromJson,
    );
  }
}
