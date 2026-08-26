import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

class BaseResponse {
  @JsonKey(name: 'resultCode')
  final int? resultCode;

  @JsonKey(name: 'failures')
  final List<String>? failures;

  BaseResponse({this.resultCode, this.failures});

  bool get hasFailures =>
      failures?.any((failure) => failure.trim().isNotEmpty) == true;

  bool get isErrorEnvelope =>
      (resultCode != null && resultCode != 0) ||
      (resultCode == null && hasFailures);

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    final rawResultCode = json['resultCode'] ?? json['ResultCode'];
    final rawFailures = json['failures'] ??
        json['Failures'] ??
        json['message'] ??
        json['Message'];

    return BaseResponse(
      resultCode: rawResultCode is int
          ? rawResultCode
          : int.tryParse(rawResultCode?.toString() ?? ''),
      failures: _parseFailures(rawFailures),
    );
  }

  static List<String>? _parseFailures(dynamic rawFailures) {
    if (rawFailures == null) return null;

    if (rawFailures is List) {
      final failures = rawFailures
          .map((failure) => failure.toString().trim())
          .where((failure) => failure.isNotEmpty)
          .toList();
      return failures.isEmpty ? null : failures;
    }

    final failure = rawFailures.toString().trim();
    return failure.isEmpty ? null : [failure];
  }
}

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> extends BaseResponse {
  List<T>? data;

  BaseListResponse({
    super.failures,
    super.resultCode,
    this.data,
  });

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) {
    final baseResponse = BaseResponse.fromJson(json);

    // Error responses must reach ApiResultConverter untouched. Parsing an
    // error payload can throw before resultCode (especially code 3) is handled.
    if (baseResponse.isErrorEnvelope) {
      return BaseListResponse<T>(
        resultCode: baseResponse.resultCode,
        failures: baseResponse.failures,
      );
    }

    final parsedData = <T>[];
    final rawData = json['data'] ?? json['Data'];

    if (rawData is List) {
      parsedData.addAll(
        rawData.map((item) => create(Map<String, dynamic>.from(item as Map))),
      );
    } else if (rawData is Map) {
      final firstList = rawData.values.firstWhere(
        (value) => value is List,
        orElse: () => <dynamic>[],
      );

      if (firstList is List) {
        parsedData.addAll(
          firstList.map(
            (item) => create(Map<String, dynamic>.from(item as Map)),
          ),
        );
      }
    }

    return BaseListResponse<T>(
      resultCode: baseResponse.resultCode ?? 0,
      failures: baseResponse.failures,
      data: parsedData,
    );
  }
}

@JsonSerializable(genericArgumentFactories: true)
class BaseSingleResponse<T> extends BaseResponse {
  T? data;

  BaseSingleResponse({
    super.failures,
    super.resultCode,
    this.data,
  });

  factory BaseSingleResponse.fromRootJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) {
    final baseResponse = BaseResponse.fromJson(json);

    if (baseResponse.isErrorEnvelope) {
      return BaseSingleResponse<T>(
        failures: baseResponse.failures,
        resultCode: baseResponse.resultCode,
      );
    }

    return BaseSingleResponse<T>(
      failures: baseResponse.failures,
      resultCode: baseResponse.resultCode ?? 0,
      data: create(json),
    );
  }

  factory BaseSingleResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) {
    final baseResponse = BaseResponse.fromJson(json);

    // Do not parse data on error responses. This guarantees resultCode 3 is
    // handled by the global token-expired flow instead of being masked by a
    // model parsing exception.
    if (baseResponse.isErrorEnvelope) {
      return BaseSingleResponse<T>(
        failures: baseResponse.failures,
        resultCode: baseResponse.resultCode,
      );
    }

    final rawData = json['data'] ?? json['Data'];

    return BaseSingleResponse<T>(
      failures: baseResponse.failures,
      resultCode: baseResponse.resultCode ?? 0,
      data: rawData is Map
          ? create(Map<String, dynamic>.from(rawData))
          : rawData is T
              ? rawData
              : null,
    );
  }
}
