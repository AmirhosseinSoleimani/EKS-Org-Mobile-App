import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/change_password_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProfileService {
  ProfileService(this._dio);

  final Dio _dio;

  Options get _jsonOptions => Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      );

  Future<BaseSingleResponse<String>> changePassword(
    ChangePasswordRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/User/ChangePassword',
      data: request.toJson(),
      options: _jsonOptions,
    );

    return _stringResponse(response.data);
  }

  Future<BaseSingleResponse<String>> logOff() async {
    final response = await _dio.post<dynamic>(
      '/api/User/LogOff',
      options: _jsonOptions,
    );

    return _stringResponse(response.data);
  }

  BaseSingleResponse<String> _stringResponse(dynamic raw) {
    final decoded = _decodeResponse(raw);

    if (decoded is Map) {
      final json = Map<String, dynamic>.from(decoded);
      return BaseSingleResponse<String>(
        resultCode: _resultCode(json),
        data: (json['data'] ?? json['Data'])?.toString() ?? '',
        failures: _failures(json),
      );
    }

    return BaseSingleResponse<String>(
      resultCode: 0,
      data: decoded?.toString() ?? '',
      failures: const <String>[],
    );
  }

  dynamic _decodeResponse(dynamic raw) {
    if (raw is! String) return raw;

    final value = raw.trim();
    if (value.isEmpty) return '';

    try {
      return jsonDecode(value);
    } on FormatException {
      return value;
    }
  }

  int _resultCode(Map<String, dynamic> json) {
    final raw = json['resultCode'] ?? json['ResultCode'];
    if (raw == null) return 0;
    if (raw is int) return raw;
    return int.tryParse(raw.toString()) ?? 0;
  }

  List<String> _failures(Map<String, dynamic> json) {
    final rawFailures = json['failures'] ?? json['Failures'];
    final rawMessage = json['message'] ?? json['Message'];

    if (rawFailures is List) {
      return rawFailures
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }

    if (rawFailures?.toString().trim().isNotEmpty == true) {
      return <String>[rawFailures.toString()];
    }

    if (rawMessage?.toString().trim().isNotEmpty == true) {
      return <String>[rawMessage.toString()];
    }

    return const <String>[];
  }
}
