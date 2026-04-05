import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data, List<String>? failures, int? resultCode}) = Success<T>;

  const factory ApiResult.failure({NetworkExceptions? error, String? failures}) = Failure<T>;

  const factory ApiResult.expireToken() = ExpireToken<T>;
  const factory ApiResult.connectionError() = ConnectionError<T>;
}
