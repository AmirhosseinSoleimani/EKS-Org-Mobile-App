import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

class BaseResponse {
  @JsonKey(name: 'resultCode')
  final int? resultCode;

  @JsonKey(name: 'failures')
  final List<String>? failures;

  BaseResponse({this.resultCode, this.failures});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    final rawResultCode = json['resultCode'] ?? json['ResultCode'];
    final rawFailures = json['failures'] ?? json['Failures'];

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
      return rawFailures.map((failure) => failure.toString()).toList();
    }

    return [rawFailures.toString()];
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
      resultCode: baseResponse.resultCode,
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

  factory BaseSingleResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) {
    final baseResponse = BaseResponse.fromJson(json);
    final rawData = json['data'] ?? json['Data'];

    return BaseSingleResponse<T>(
      failures: baseResponse.failures,
      resultCode: baseResponse.resultCode,
      data: rawData is Map
          ? create(Map<String, dynamic>.from(rawData))
          : null,
    );
  }
}
