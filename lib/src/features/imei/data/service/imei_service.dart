import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/device_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/device_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_mutation_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ImeiService {
  ImeiService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<ImeiInfoPageModel>> getByFilter(
    ImeiInfoFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/IMEIInfo/GetByFilterJson',
      data: request.toJson(),
    );

    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<List<DeviceInfoModel>>> getDeviceTypes(
    DeviceInfoFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/DeviceInfo/GetByFilterJson',
      data: request.toJson(),
    );

    return _deviceListResponse(response.data);
  }

  Future<BaseSingleResponse<ImeiInfoModel>> getById(
    ImeiInfoIdRequestModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/IMEIInfo/GetById',
      queryParameters: request.toJson(),
    );

    return _singleImeiResponse(response.data);
  }

  Future<BaseSingleResponse<String>> add(
    ImeiInfoMutationRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/IMEIInfo/post',
      data: request.toJson(),
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> update(
    ImeiInfoMutationRequestModel request,
  ) async {
    final response = await _dio.put<dynamic>(
      '/api/IMEIInfo/put',
      data: request.toJson(),
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> delete(
    ImeiInfoIdRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/IMEIInfo/DeleteByID',
      queryParameters: request.toDeleteJson(),
    );

    return _stringMutationResponse(response.data);
  }

  BaseSingleResponse<ImeiInfoPageModel> _pageResponse(dynamic data) {
    final json = _normalizePageResponse(data);
    return BaseSingleResponse<ImeiInfoPageModel>(
      resultCode: _readResultCode(json),
      data: ImeiInfoPageModel.fromJson(json),
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<List<DeviceInfoModel>> _deviceListResponse(dynamic data) {
    final json = _normalizeListResponse(data);
    final rawData = json['data'] ?? json['Data'];
    final itemJson = rawData == null
        ? ImeiJsonHelper.pageRecords(json)
        : rawData is Map
        ? ImeiJsonHelper.pageRecords(json)
        : ImeiJsonHelper.mapList(rawData);
    final items = itemJson.map(DeviceInfoModel.fromJson).toList();

    return BaseSingleResponse<List<DeviceInfoModel>>(
      resultCode: _readResultCode(json),
      data: items,
      failures: _readFailures(json),
    );
  }

  BaseSingleResponse<ImeiInfoModel> _singleImeiResponse(dynamic data) {
    final json = _normalizeSingleResponse(data);
    final rawData = ImeiJsonHelper.responseData(json);
    final itemJson = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : const <String, dynamic>{};

    return BaseSingleResponse<ImeiInfoModel>(
      resultCode: _readResultCode(json),
      data: ImeiInfoModel.fromJson(itemJson),
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

  Map<String, dynamic> _normalizePageResponse(dynamic data) {
    if (data is List) {
      return {
        'resultCode': 0,
        'data': {
          'records': data,
          'count': data.length,
        },
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
        'data': {
          'records': [mappedData],
          'count': 1,
        },
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

      return {
        'resultCode': 0,
        'data': [mappedData],
      };
    }

    return {
      'resultCode': 0,
      'data': data is List ? data : <dynamic>[],
    };
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

      return {
        'resultCode': 0,
        'data': mappedData,
      };
    }

    return const {
      'resultCode': 0,
      'data': null,
    };
  }

  int _readResultCode(Map<String, dynamic> json) {
    return ImeiJsonHelper.integer(json['resultCode'] ?? json['ResultCode']) ?? 0;
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
