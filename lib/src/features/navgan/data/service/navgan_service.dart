import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_page_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_service_group_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/grade_pattern_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_grade_reference_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_ids_payload_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavganService {
  NavganService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<NavganPageModel>> getByFilter() async {
    final response = await _dio.post<dynamic>(
      '/api/EmdadgarNavgan/GetByFilterJson',
    );

    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<List<GradePatternModel>>> getGradePatterns(
    GradePatternFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/GradePattern/GetByFilterJson',
      data: request.toJson(),
    );

    return _gradePatternListResponse(response.data);
  }

  Future<BaseSingleResponse<GradePatternModel>> getGradePatternById(
    NavganIdRequestModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/GradePattern/GetById',
      queryParameters: request.toJson(),
    );

    return _singleGradePatternResponse(response.data);
  }

  Future<BaseSingleResponse<String>> addGradeReference(
    NavganGradeReferenceRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/GradePatternReference/Post',
      data: request.toJson(),
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> deleteGradeReference(
    NavganIdRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/GradePatternReference/DeleteByID',
      queryParameters: request.toDeleteJson(),
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<List<NavganServiceGroupModel>>> getServiceGroups(
    NavganIdRequestModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/EmdadgarNavgan/GetEmdadServiceCategoryGroupingByServiceTypeTitleSelctedForNavganlId',
      queryParameters: {'navganId': request.id},
    );

    return _serviceGroupListResponse(response.data);
  }

  Future<BaseSingleResponse<List<NavganDefectModel>>> getDefects(
    NavganServiceCategoryRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/EmdadgarNavgan/GetDefectsByNavganIdAndServiceCategoryId',
      data: request.toJson(),
    );

    return _defectListResponse(response.data);
  }

  Future<BaseSingleResponse<String>> submitServiceCategories(
    NavganIdsPayloadRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/EmdadgarNavgan/InsertBatchEmdadServiceCategoriesByNavganId',
      data: request.toJson(),
    );

    return _voidMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> submitDefects(
    NavganIdsPayloadRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/EmdadgarNavgan/SubmitNavganDefectLimitation',
      data: request.toJson(),
    );

    return _voidMutationResponse(response.data);
  }

  BaseSingleResponse<NavganPageModel> _pageResponse(dynamic data) {
    final json = _normalizePageResponse(data);
    return BaseSingleResponse<NavganPageModel>(
      resultCode: _readResultCode(json),
      data: NavganPageModel.fromJson(json),
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<GradePatternModel>> _gradePatternListResponse(
    dynamic data,
  ) {
    final json = _normalizeListResponse(data);
    final items = _readItemList(json).map(GradePatternModel.fromJson).toList();
    return BaseSingleResponse<List<GradePatternModel>>(
      resultCode: _readResultCode(json),
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<GradePatternModel> _singleGradePatternResponse(
    dynamic data,
  ) {
    final json = _normalizeSingleResponse(data);
    final rawData = NavganJsonHelper.responseData(json);
    final itemJson = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : const <String, dynamic>{};

    return BaseSingleResponse<GradePatternModel>(
      resultCode: _readResultCode(json),
      data: GradePatternModel.fromJson(itemJson),
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<NavganServiceGroupModel>> _serviceGroupListResponse(
    dynamic data,
  ) {
    final json = _normalizeListResponse(data);
    final items =
        _readItemList(json).map(NavganServiceGroupModel.fromJson).toList();
    return BaseSingleResponse<List<NavganServiceGroupModel>>(
      resultCode: _readResultCode(json),
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<NavganDefectModel>> _defectListResponse(dynamic data) {
    final json = _normalizeListResponse(data);
    final items = _readItemList(json).map(NavganDefectModel.fromJson).toList();
    return BaseSingleResponse<List<NavganDefectModel>>(
      resultCode: _readResultCode(json),
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
    if (rawData == null) return NavganJsonHelper.pageRecords(json);
    if (rawData is Map) return NavganJsonHelper.pageRecords(json);
    return NavganJsonHelper.mapList(rawData);
  }

  Map<String, dynamic> _normalizePageResponse(dynamic data) {
    if (data is List) {
      return {
        'resultCode': 0,
        'data': {'records': data, 'count': data.length},
      };
    }

    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      final hasEnvelope = mappedData.containsKey('data') ||
          mappedData.containsKey('Data') ||
          mappedData.containsKey('records') ||
          mappedData.containsKey('Records') ||
          mappedData.containsKey('items') ||
          mappedData.containsKey('Items') ||
          mappedData.containsKey('resultCode') ||
          mappedData.containsKey('ResultCode') ||
          mappedData.containsKey('message') ||
          mappedData.containsKey('Message') ||
          mappedData.containsKey('failures') ||
          mappedData.containsKey('Failures');
      if (hasEnvelope) return mappedData;

      return {
        'resultCode': 0,
        'data': {'records': [mappedData], 'count': 1},
      };
    }

    return const <String, dynamic>{};
  }

  Map<String, dynamic> _normalizeListResponse(dynamic data) {
    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      if (mappedData.containsKey('data') ||
          mappedData.containsKey('Data') ||
          mappedData.containsKey('records') ||
          mappedData.containsKey('Records') ||
          mappedData.containsKey('items') ||
          mappedData.containsKey('Items') ||
          mappedData.containsKey('resultCode') ||
          mappedData.containsKey('ResultCode') ||
          mappedData.containsKey('message') ||
          mappedData.containsKey('Message') ||
          mappedData.containsKey('failures') ||
          mappedData.containsKey('Failures')) {
        return mappedData;
      }

      return {'resultCode': 0, 'data': [mappedData]};
    }

    return {'resultCode': 0, 'data': data is List ? data : <dynamic>[]};
  }

  Map<String, dynamic> _normalizeSingleResponse(dynamic data) {
    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      if (mappedData.containsKey('data') ||
          mappedData.containsKey('Data') ||
          mappedData.containsKey('resultCode') ||
          mappedData.containsKey('ResultCode')) {
        return mappedData;
      }

      return {'resultCode': 0, 'data': mappedData};
    }

    return const {'resultCode': 0, 'data': null};
  }

  int _readResultCode(Map<String, dynamic> json) {
    return NavganJsonHelper.integer(json['resultCode'] ?? json['ResultCode']) ??
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
