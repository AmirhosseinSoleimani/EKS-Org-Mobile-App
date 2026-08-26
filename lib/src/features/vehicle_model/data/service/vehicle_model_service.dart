import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_ids_payload_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_page_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_navgan_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_service_group_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VehicleModelService {
  VehicleModelService(this._dio);

  final Dio _dio;

  Options get _jsonOptions => Options(contentType: Headers.jsonContentType);

  Future<BaseSingleResponse<VehicleModelPageModel>> getByFilter(
    VehicleModelFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/VehicleModel/GetByFilterJson',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<List<VehicleNavganModel>>> getNavgans() async {
    final response = await _dio.post<dynamic>(
      '/api/EmdadgarNavgan/GetByFilterJson',
      data: const {
        'Sort': [],
        'Filter': {'Logic': 'and', 'Filters': []},
        'Skip': 0,
        'PageSize': 0,
      },
      options: _jsonOptions,
    );
    return _navganListResponse(response.data);
  }

  Future<BaseSingleResponse<List<VehicleServiceGroupModel>>> getServiceGroups(
    VehicleModelIdRequestModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/VehicleModel/GetEmdadServiceCategoryGroupingByServiceTypeTitleSelctedForVehicleModelId',
      queryParameters: request.toJson(),
      options: _jsonOptions,
    );
    return _serviceGroupListResponse(response.data);
  }

  Future<BaseSingleResponse<List<VehicleDefectModel>>> getDefects(
    VehicleModelServiceCategoryRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/VehicleModel/GetDefectsByVehicleModelIdAndServiceCategoryId',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _defectListResponse(response.data);
  }

  Future<BaseSingleResponse<String>> submitDefects(
    VehicleModelIdsPayloadRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/VehicleModel/SubmitVehicleModelDefectLimitation',
      data: request.toDefectsJson(),
      options: _jsonOptions,
    );
    return _voidMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> submitServiceCategories(
    VehicleModelIdsPayloadRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/VehicleModel/InsertBatchEmdadServiceCategoriesByVehicleModelId',
      data: request.toServiceCategoriesJson(),
      options: _jsonOptions,
    );
    return _voidMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> deleteById(
    VehicleModelIdRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/VehicleModel/DeleteByID',
      queryParameters: request.toJson(),
      options: _jsonOptions,
    );
    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> updateVehicleModel(
    VehicleModelFormRequestModel request,
  ) async {
    final response = await _dio.put<dynamic>(
      '/api/VehicleModel/put',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> addVehicleModel(
    VehicleModelFormRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/VehicleModel/post',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _stringMutationResponse(response.data);
  }

  BaseSingleResponse<VehicleModelPageModel> _pageResponse(dynamic data) {
    final json = _normalizePageResponse(data);
    final resultCode = _readResultCode(json);
    return BaseSingleResponse<VehicleModelPageModel>(
      resultCode: resultCode,
      data: resultCode == 0 ? VehicleModelPageModel.fromJson(json) : null,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<VehicleNavganModel>> _navganListResponse(dynamic data) {
    final json = _normalizeListResponse(data);
    final resultCode = _readResultCode(json);
    final items = resultCode == 0
        ? _readItemList(json).map(VehicleNavganModel.fromJson).toList()
        : null;
    return BaseSingleResponse<List<VehicleNavganModel>>(
      resultCode: resultCode,
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<VehicleServiceGroupModel>> _serviceGroupListResponse(
    dynamic data,
  ) {
    final json = _normalizeListResponse(data);
    final resultCode = _readResultCode(json);
    final items = resultCode == 0
        ? _readItemList(json).map(VehicleServiceGroupModel.fromJson).toList()
        : null;
    return BaseSingleResponse<List<VehicleServiceGroupModel>>(
      resultCode: resultCode,
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<VehicleDefectModel>> _defectListResponse(dynamic data) {
    final json = _normalizeListResponse(data);
    final resultCode = _readResultCode(json);
    final items = resultCode == 0
        ? _readItemList(json).map(VehicleDefectModel.fromJson).toList()
        : null;
    return BaseSingleResponse<List<VehicleDefectModel>>(
      resultCode: resultCode,
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<String> _stringMutationResponse(dynamic data) {
    if (data is Map) {
      final json = Map<String, dynamic>.from(data);
      return BaseSingleResponse<String>(
        resultCode: _readResultCode(json),
        data: (json['data'] ?? json['Data'])?.toString() ?? '',
        failures: _readFailures(json),
      );
    }
    return BaseSingleResponse<String>(
      resultCode: 0,
      data: data?.toString() ?? '',
      failures: const [],
    );
  }

  BaseSingleResponse<String> _voidMutationResponse(dynamic data) {
    if (data == null || data.toString().trim().isEmpty) {
      return BaseSingleResponse<String>(
        resultCode: 0,
        data: '',
        failures: const [],
      );
    }
    return _stringMutationResponse(data);
  }

  List<Map<String, dynamic>> _readItemList(Map<String, dynamic> json) {
    final rawData = json['data'] ?? json['Data'];
    if (rawData == null || rawData is Map) {
      return VehicleModelJsonHelper.pageRecords(json);
    }
    return VehicleModelJsonHelper.mapList(rawData);
  }

  Map<String, dynamic> _normalizePageResponse(dynamic data) {
    if (data is List) {
      return {
        'resultCode': 0,
        'data': {'records': data, 'count': data.length},
      };
    }
    if (data is Map) return Map<String, dynamic>.from(data);
    return const <String, dynamic>{};
  }

  Map<String, dynamic> _normalizeListResponse(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    return {'resultCode': 0, 'data': data is List ? data : <dynamic>[]};
  }

  int _readResultCode(Map<String, dynamic> json) {
    return VehicleModelJsonHelper.integer(
          json['resultCode'] ?? json['ResultCode'],
        ) ??
        0;
  }

  List<String> _readFailures(Map<String, dynamic> json) {
    final rawFailures = json['failures'] ?? json['Failures'];
    final message = json['message'] ?? json['Message'];
    if (rawFailures is List) {
      return rawFailures
          .map((item) => item.toString())
          .where((item) => item.trim().isNotEmpty)
          .toList();
    }
    if (rawFailures?.toString().trim().isNotEmpty == true) {
      return <String>[rawFailures.toString()];
    }
    if (message?.toString().trim().isNotEmpty == true) {
      return <String>[message.toString()];
    }
    return const [];
  }
}
