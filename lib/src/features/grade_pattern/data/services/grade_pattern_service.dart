import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_page_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_reference_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GradePatternService {
  GradePatternService(this._dio);

  final Dio _dio;

  Future<GradePatternPageModel> getByFilter(
    GradePatternFilterRequestModel request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/GradePattern/GetByFilterJson',
      data: request.toJson(),
    );
    return GradePatternPageModel.fromJson(response.data ?? {});
  }

  Future<BaseSingleResponse<GradePatternModel>> getById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/GradePattern/GetById',
      queryParameters: {'Id': id},
    );
    return BaseSingleResponse<GradePatternModel>.fromJson(
      response.data ?? {},
      GradePatternModel.fromJson,
    );
  }

  Future<BaseSingleResponse<GradePatternModel>> create(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/GradePattern/post',
      data: body,
    );
    return BaseSingleResponse<GradePatternModel>.fromJson(
      _normalizePatternMutationResponse(response.data, body),
      GradePatternModel.fromJson,
    );
  }

  Future<BaseSingleResponse<GradePatternModel>> update(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.put<dynamic>(
      '/api/GradePattern/put',
      data: body,
    );
    return BaseSingleResponse<GradePatternModel>.fromJson(
      _normalizePatternMutationResponse(response.data, body),
      GradePatternModel.fromJson,
    );
  }

  Future<BaseResponse> deleteById(int id) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/api/GradePattern/DeleteByID',
      queryParameters: {'id': id},
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseListResponse<GradePatternReferenceModel>> referenceGetByFilter(
    GradePatternFilterRequestModel request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/GradePatternReference/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseListResponse<GradePatternReferenceModel>.fromJson(
      response.data ?? {},
      GradePatternReferenceModel.fromJson,
    );
  }

  Future<BaseResponse> referencePost(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/GradePatternReference/Post',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Future<BaseResponse> referenceDeleteById(int id) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/api/GradePatternReference/DeleteByID',
      queryParameters: {'id': id},
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  Map<String, dynamic> _normalizePatternMutationResponse(
    dynamic rawResponse,
    Map<String, dynamic> requestBody,
  ) {
    final response = rawResponse is Map
        ? Map<String, dynamic>.from(rawResponse)
        : <String, dynamic>{};
    final rawData = _read(response, 'data', 'Data') ?? rawResponse;

    final resultCode = _toInt(_read(response, 'resultCode', 'ResultCode')) ?? 0;

    if (rawData is Map) {
      final data = Map<String, dynamic>.from(rawData);
      return {
        ...response,
        'resultCode': resultCode,
        'ResultCode': resultCode,
        'data': data,
        'Data': data,
      };
    }

    final id = _toInt(rawData);
    if (id == null) {
      return response;
    }

    final data = Map<String, dynamic>.from(requestBody);
    data['id'] = id;

    return {
      ...response,
      'resultCode': resultCode,
      'ResultCode': resultCode,
      'data': data,
      'Data': data,
    };
  }

  dynamic _read(
    Map<String, dynamic> json,
    String camelCaseKey,
    String pascalCaseKey,
  ) {
    return json[camelCaseKey] ?? json[pascalCaseKey];
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString().replaceAll(RegExp(r'[^0-9-]'), ''));
  }
}
