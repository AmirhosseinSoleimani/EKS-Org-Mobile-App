import 'package:eks_sana_plus_org/src/common/event_bus/app_event_bus.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/error/network_exceptions.dart';

import 'api_result.dart';

const _unexpectedApiError =
    'خطای غیرمنتظره، لطفا با شماره 096550 تماس بگیرید';

String _failureMessage(BaseResponse response) {
  final failures = response.failures
      ?.where((failure) => failure.trim().isNotEmpty)
      .toList(growable: false);
  return failures == null || failures.isEmpty
      ? _unexpectedApiError
      : failures.listToString();
}

bool _isSuccess(BaseResponse response) {
  if (response.resultCode == 0) return true;
  if (response.resultCode != null) return false;

  // Some legacy endpoints return an empty/primitive 2xx response without a
  // resultCode. Keep those successful only when the server did not provide an
  // error message/failure either.
  return response.failures?.any((failure) => failure.trim().isNotEmpty) != true;
}

ApiResult<T> _baseResponseToApiResult<T>(
  BaseResponse response, {
  required T data,
}) {
  if (_isSuccess(response)) {
    return ApiResult<T>.success(
      data: data,
      failures: response.failures,
      resultCode: response.resultCode ?? 0,
    );
  }

  switch (response.resultCode) {
    case 3:
      AppEventBus.emit(AppEvent.tokenExpired);
      return ApiResult<T>.expireToken();
    case 1:
    case 2:
    case 4:
    case null:
    default:
      return ApiResult<T>.failure(
        failures: _failureMessage(response),
      );
  }
}

extension ErrorApiResultExtension on Object {
  ApiResult<T> toApiResult<T>(StackTrace? stackTrace) {
    final error = NetworkExceptions.getDioException(this, stackTrace);
    final str = NetworkExceptions.getErrorMessage(error);
    return error.whenOrNull(
          noInternetConnection: () => ApiResult<T>.connectionError(),
        ) ??
        ApiResult.failure(
          error: error,
          failures: str,
        );
  }
}

extension BaseResponseApiResultExtension on BaseResponse {
  ApiResult<void> toApiResult() {
    return _baseResponseToApiResult<void>(this, data: null);
  }
}

extension SuccessApiResultExtension<T> on BaseSingleResponse<T> {
  ApiResult<R> toApiResult<R>() {
    return _baseResponseToApiResult<R>(
      this,
      data: data as dynamic,
    );
  }
}

extension SuccessApiListResultExtension<T> on BaseListResponse<T> {
  ApiResult<List<R>> toApiResult<R>() {
    return _baseResponseToApiResult<List<R>>(
      this,
      data: data == null ? <R>[] : data!.cast<R>(),
    );
  }

  @Deprecated('Use toApiResult() so every list response follows one path.')
  ApiResult<List<R>> toApiResultList<R>() => toApiResult<R>();
}
