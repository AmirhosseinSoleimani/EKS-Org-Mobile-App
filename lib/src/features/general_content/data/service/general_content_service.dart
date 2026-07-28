import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_page_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_target_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_target_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeneralContentService {
  GeneralContentService(this._dio);

  final Dio _dio;

  Options get _jsonOptions => Options(contentType: Headers.jsonContentType);

  Future<BaseSingleResponse<GeneralContentPageModel>> getByFilter(
    GeneralContentFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/GeneralContent/GetByFilterJson',
      data: request.toJson(),
      options: _jsonOptions,
    );

    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<List<GeneralContentTargetModel>>> getTargets(
    GeneralContentIdRequestModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/GeneralContent/GeneralContentTargets',
      queryParameters: request.toJson(),
      options: _jsonOptions,
    );

    return _targetListResponse(response.data);
  }

  Future<BaseSingleResponse<GeneralContentTargetModel>> addTarget(
    GeneralContentTargetRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/GeneralContent/AddGeneralContentTarget',
      data: request.toJson(),
      options: _jsonOptions,
    );

    return _singleTargetResponse(response.data);
  }

  Future<BaseSingleResponse<String>> addGeneralContent(
    GeneralContentFormRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/GeneralContent/AddGeneralContent',
      data: await request.toFormData(includeFile: true),
    );

    return _voidMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> updateGeneralContent(
    GeneralContentFormRequestModel request,
  ) async {
    final response = await _dio.put<dynamic>(
      '/api/GeneralContent/UpdateGeneralContent',
      data: await request.toFormData(),
    );

    return _voidMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> deleteById(
    GeneralContentIdRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/GeneralContent/DeleteByID',
      queryParameters: request.toJson(),
      options: _jsonOptions,
    );

    return _stringMutationResponse(response.data);
  }

  BaseSingleResponse<GeneralContentPageModel> _pageResponse(dynamic data) {
    final json = _normalizePageResponse(data);
    return BaseSingleResponse<GeneralContentPageModel>(
      resultCode: _readResultCode(json),
      data: GeneralContentPageModel.fromJson(json),
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<GeneralContentTargetModel>> _targetListResponse(
    dynamic data,
  ) {
    final json = _normalizeListResponse(data);
    final items = _readItemList(json)
        .map(GeneralContentTargetModel.fromJson)
        .where((item) => item.id != null)
        .toList();

    return BaseSingleResponse<List<GeneralContentTargetModel>>(
      resultCode: _readResultCode(json),
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<GeneralContentTargetModel> _singleTargetResponse(
    dynamic data,
  ) {
    final json = _normalizeSingleResponse(data);
    final rawData = GeneralContentJsonHelper.responseData(json);
    final itemJson = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : const <String, dynamic>{};

    return BaseSingleResponse<GeneralContentTargetModel>(
      resultCode: _readResultCode(json),
      data: GeneralContentTargetModel.fromJson(itemJson),
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
      return GeneralContentJsonHelper.pageRecords(json);
    }
    return GeneralContentJsonHelper.mapList(rawData);
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
    return GeneralContentJsonHelper.integer(
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
