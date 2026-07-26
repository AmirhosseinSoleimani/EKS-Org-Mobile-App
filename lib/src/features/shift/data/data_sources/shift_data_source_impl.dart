import 'package:eks_sana_plus_org/src/features/shift/data/data_sources/shift_data_source.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_model.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_page_model.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/services/shift_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ShiftDataSource)
class ShiftDataSourceImpl extends ShiftDataSource {
  ShiftDataSourceImpl(this._service);

  final ShiftService _service;

  @override
  Future<ShiftPageModel> getByFilter(ShiftFilterRequestModel request) async {
    final response = await _service.getByFilter(request.toJson());
    return ShiftPageModel.fromJson(response);
  }

  @override
  Future<BaseSingleResponse<ShiftModel>> getById(int id) async {
    final response = await _service.getById(id);
    return BaseSingleResponse<ShiftModel>.fromJson(
      response,
      ShiftModel.fromJson,
    );
  }

  @override
  Future<BaseSingleResponse<ShiftModel>> create(Map<String, dynamic> body) async {
    final response = await _service.create(body);
    return BaseSingleResponse<ShiftModel>.fromJson(
      _normalizeMutationResponse(response, body),
      ShiftModel.fromJson,
    );
  }

  @override
  Future<BaseSingleResponse<ShiftModel>> update(Map<String, dynamic> body) async {
    final response = await _service.update(body);
    return BaseSingleResponse<ShiftModel>.fromJson(
      _normalizeMutationResponse(response, body),
      ShiftModel.fromJson,
    );
  }

  @override
  Future<BaseResponse> deleteById(int id) async {
    final response = await _service.deleteById(id);
    return BaseResponse.fromJson(response);
  }

  Map<String, dynamic> _normalizeMutationResponse(
    dynamic rawResponse,
    Map<String, dynamic> requestBody,
  ) {
    final response = rawResponse is Map
        ? Map<String, dynamic>.from(rawResponse)
        : <String, dynamic>{};
    final rawData = response['data'] ?? response['Data'] ?? rawResponse;
    final resultCode = _toInt(response['resultCode'] ?? response['ResultCode']) ?? 0;

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

    final id = _toInt(rawData) ?? _toInt(requestBody['id']);
    final data = Map<String, dynamic>.from(requestBody);
    if (id != null) data['id'] = id;

    return {
      ...response,
      'resultCode': resultCode,
      'ResultCode': resultCode,
      'data': data,
      'Data': data,
    };
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString().replaceAll(RegExp(r'[^0-9-]'), ''));
  }
}
