import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/add_rescuer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/delete_rescuer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/rescuer_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/san_history_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/submit_skill_certificates_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RescuerService {
  final Dio _dio;

  RescuerService(this._dio);


  Future<BaseSingleResponse<AddRescuerResponseModel>> addRescuer(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/personinfo/post',
      data: body,
    );

    final normalizedResponse = _normalizeSingleResponse(response.data);
    final baseResponse = BaseResponse.fromJson(normalizedResponse);
    final rawData = normalizedResponse['data'] ?? normalizedResponse['Data'];

    return BaseSingleResponse<AddRescuerResponseModel>(
      resultCode: baseResponse.resultCode,
      failures: baseResponse.failures,
      data: baseResponse.resultCode == 0 && rawData != null
          ? AddRescuerResponseModel.fromJson(rawData)
          : null,
    );
  }

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

  Future<BaseSingleResponse<SubmitSkillCertificatesResponseModel>>
  submitSkillCertificates(Map<String, dynamic> body) async {
    final response = await _dio.post<dynamic>(
      '/api/PersonInfo/SubmitSkillCertificates',
      data: body,
    );

    final normalizedResponse = Map<String, dynamic>.from(
      _normalizeSingleResponse(response.data),
    );
    normalizedResponse['data'] = _normalizeSubmitSkillCertificatesData(
      normalizedResponse['data'],
    );

    return BaseSingleResponse<SubmitSkillCertificatesResponseModel>.fromJson(
      normalizedResponse,
      (json) => SubmitSkillCertificatesResponseModel.fromJson(
        json as Map<String, dynamic>,
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

  Map<String, dynamic> _normalizeSubmitSkillCertificatesData(dynamic data) {
    if (data is String) {
      final message = data.trim();
      return {
        'message': message.isEmpty ? 'اطلاعات با موفقیت ثبت شد' : message,
      };
    }

    if (data is Map<String, dynamic>) {
      final message =
          data['message'] ?? data['Message'] ?? data['data'] ?? data['Data'];
      final normalizedMessage = message?.toString().trim();
      return {
        'message': normalizedMessage?.isNotEmpty == true
            ? normalizedMessage
            : 'اطلاعات با موفقیت ثبت شد',
      };
    }

    return {'message': 'اطلاعات با موفقیت ثبت شد'};
  }
}
