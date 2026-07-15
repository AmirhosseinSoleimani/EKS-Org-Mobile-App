import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/delete_rescuer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/rescuer_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/san_history_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RescuerService {
  final Dio _dio;

  RescuerService(this._dio);

  Future<BaseListResponse<RescuerModel>> getRescuers(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/PersonInfo/GetByFilterJson',
      data: body,
    );

    return BaseListResponse<RescuerModel>.fromJson(
      _normalizeListResponse(response.data),
      (json) => RescuerModel.fromJson(json),
    );
  }

  Future<BaseListResponse<RescuerModel>> getRescuerReport(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/PersonInfo/GetByFilterJson',
      data: body,
    );

    return BaseListResponse<RescuerModel>.fromJson(
      _normalizeListResponse(response.data),
      (json) => RescuerModel.fromJson(json),
    );
  }

  Future<BaseSingleResponse<RescuerModel>> getRescuerById(int id) async {
    final response = await _dio.get<dynamic>(
      '/api/personinfo/GetById',
      queryParameters: {'Id': id},
    );

    return BaseSingleResponse<RescuerModel>.fromJson(
      _normalizeSingleResponse(response.data),
      (json) => RescuerModel.fromJson(json),
    );
  }

  Future<BaseListResponse<SkillCertificateModel>> getSkillCertificates(
    int id,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/PersonInfo/GetSkillCertificates',
      queryParameters: {'id': id},
    );

    return BaseListResponse<SkillCertificateModel>.fromJson(
      _normalizeListResponse(response.data),
      (json) => SkillCertificateModel.fromJson(
        json,
      ),
    );
  }

  Future<BaseListResponse<SanHistoryModel>> getHistory(int id) async {
    final response = await _dio.get<dynamic>(
      '/api/SanHistory/GetSanLogHistoriesById',
      queryParameters: {
        'refId': id,
        'type': 3,
      },
    );

    return BaseListResponse<SanHistoryModel>.fromJson(
      _normalizeListResponse(response.data),
      (json) => SanHistoryModel.fromJson(json),
    );
  }

  Future<BaseSingleResponse<DeleteRescuerResponseModel>> deleteRescuer(
    int id,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/PersonInfo/DeleteByID',
      queryParameters: {'id': id},
    );

    return BaseSingleResponse<DeleteRescuerResponseModel>.fromJson(
      _normalizeSingleResponse(response.data),
      DeleteRescuerResponseModel.fromJson,
    );
  }

  Map<String, dynamic> _normalizeListResponse(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('resultCode')) {
      return data;
    }

    return {
      'resultCode': 0,
      'failures': null,
      'data': data is List ? data : <dynamic>[],
    };
  }

  Map<String, dynamic> _normalizeSingleResponse(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('resultCode')) {
      return data;
    }

    return {
      'resultCode': 0,
      'failures': null,
      'data': data,
    };
  }
}
