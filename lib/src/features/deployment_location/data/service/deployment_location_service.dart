import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_page_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_id_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeploymentLocationService {
  DeploymentLocationService(this._dio);

  final Dio _dio;

  Options get _jsonOptions => Options(contentType: Headers.jsonContentType);

  Future<BaseSingleResponse<DeploymentLocationPageModel>> getByFilter(
    DeploymentLocationFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Location/GetByFilterJson',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<DeploymentLocationModel>> getById(
    DeploymentLocationIdRequestModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/Location/GetById',
      queryParameters: request.toGetJson(),
      options: _jsonOptions,
    );
    return _itemResponse(response.data);
  }

  Future<BaseSingleResponse<String>> create(
    DeploymentLocationFormRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Location/post',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _mutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> update(
    DeploymentLocationFormRequestModel request,
  ) async {
    final response = await _dio.put<dynamic>(
      '/api/Location/put',
      data: request.toJson(),
      options: _jsonOptions,
    );
    return _mutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> deleteById(
    DeploymentLocationIdRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/Location/DeleteByID',
      queryParameters: request.toDeleteJson(),
      options: _jsonOptions,
    );
    return _mutationResponse(response.data);
  }

  BaseSingleResponse<DeploymentLocationPageModel> _pageResponse(dynamic data) {
    final json = _normalizePageResponse(data);
    final resultCode = _readResultCode(json);
    return BaseSingleResponse<DeploymentLocationPageModel>(
      resultCode: resultCode,
      data: resultCode == 0 ? DeploymentLocationPageModel.fromJson(json) : null,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<DeploymentLocationModel> _itemResponse(dynamic data) {
    final json = _normalizeObjectResponse(data);
    final resultCode = _readResultCode(json);
    return BaseSingleResponse<DeploymentLocationModel>(
      resultCode: resultCode,
      data: resultCode == 0
          ? DeploymentLocationModel.fromJson(
              DeploymentLocationJsonHelper.objectData(json),
            )
          : null,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<String> _mutationResponse(dynamic data) {
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

  Map<String, dynamic> _normalizeObjectResponse(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    return const <String, dynamic>{};
  }

  int _readResultCode(Map<String, dynamic> json) {
    return DeploymentLocationJsonHelper.integer(
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
          .toList(growable: false);
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
