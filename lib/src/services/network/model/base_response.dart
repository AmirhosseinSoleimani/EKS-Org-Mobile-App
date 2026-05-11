import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

class BaseResponse {
  @JsonKey(name: 'resultCode')
  final int? resultCode;
  @JsonKey(name: 'failures')
  final List<String>? failures;

  BaseResponse({this.resultCode, this.failures});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      resultCode: json["resultCode"],
      failures: json["failures"] != null
          ? (json["failures"] as List<String>).map((e) => e).toList()
          : null,
    );
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
    List<T> parsedData = [];

    final rawData = json['data'];

    if (rawData is List) {
      parsedData = rawData.map((e) => create(e as Map<String, dynamic>)).toList();
    } else if (rawData is Map<String, dynamic>) {
      final firstList = rawData.values.firstWhere(
            (v) => v is List,
        orElse: () => <dynamic>[],
      );
      if (firstList is List) {
        parsedData = firstList.map((e) => create(e as Map<String, dynamic>)).toList();
      }
    }

    List<String>? parsedFailures;
    if (json['failures'] != null) {
      parsedFailures = (json['failures'] as List).map((e) => e.toString()).toList();
    } else if (json['Failures'] != null) {
      parsedFailures = (json['Failures'] as List).map((e) => e.toString()).toList();
    } else {
      parsedFailures = [];
    }

    return BaseListResponse<T>(
      resultCode: json['resultCode'],
      failures: parsedFailures,
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
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    List<String>? failures;
    if (json["failures"] != null) {
      failures = (json["failures"] as List).map((e) => e.toString()).toList();
    } else if (json["Failures"] != null) {
      failures = (json["Failures"] as List).map((e) => e.toString()).toList();
    } else {
      failures = [];
    }
    return BaseSingleResponse<T>(
        failures: failures,
        resultCode: json["resultCode"] ?? json["ResultCode"],
        data: json['data'] != null
            ? create(json['data'])
            : json['Data'] != null
                ? create(json['Data'])
                : null);
  }
}
