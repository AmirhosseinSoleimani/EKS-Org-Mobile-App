import 'package:eks_sana_plus_org/src/common/event_bus/app_event_bus.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/error/network_exceptions.dart';

import 'api_result.dart';


extension ErrorApiResultExtension on Object {
  ApiResult<T> toApiResult<T>(StackTrace? stackTrace) {
    final error = NetworkExceptions.getDioException(this, stackTrace);
    final str = NetworkExceptions.getErrorMessage(error);
    return error.whenOrNull(
      noInternetConnection: () => ApiResult<T>.connectionError(),
    ) ?? ApiResult.failure(error: error, failures: str,
    );
  }
}


/*extension ErrorApiResultExtension on Object {
  ApiResult<T> toApiResult<T>(StackTrace? stackTrace) {
    final error = NetworkExceptions.getDioException(this, stackTrace);
    final str = NetworkExceptions.getErrorMessage(error);
    return ApiResult.failure(error: error, failures: str);
  }
}*/

extension SuccessApiResultExtension on BaseSingleResponse {
  ApiResult<T> toApiResult<T>() {
    switch(resultCode) {
      case 0:
        final apiResult = ApiResult<T>.success(
            data: data, failures: failures, resultCode: resultCode);
        return apiResult;
      case 1:
      case 2:
      case 4:
        final apiResult = ApiResult<T>.failure(
          failures: failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شمارخ 096550 تماس بگیرید',
        );
        return apiResult;
      case 3:
        AppEventBus.emit(AppEvent.tokenExpired);
        return ApiResult<T>.expireToken();
      default:
        final apiResult = ApiResult<T>.failure(
          failures: failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شمارخ 096550 تماس بگیرید',
        );
        return apiResult;
    }
  }
}

extension SuccessApiListResultExtension on BaseListResponse {
  ApiResult<List<T>> toApiResult<T>() {
    final List<T> safeData = () {
      final d = data;
      if (d == null) return <T>[];
      if (d is List<T>) return d;
      return d.cast<T>();
    }();

    switch (resultCode) {
      case 0:
        return ApiResult<List<T>>.success(
          data: safeData,
          failures: failures,
          resultCode: resultCode,
        );
      case 3:
        AppEventBus.emit(AppEvent.tokenExpired);
        return ApiResult<List<T>>.expireToken();
      case 1:
      case 2:
      case 4:
      default:
        return ApiResult<List<T>>.failure(
          failures: failures?.listToString() ??
              'خطای غیرمنتظره، لطفا با شماره 096550 تماس بگیرید',
        );
    }
  }
}



extension SuccessApiResultListExtension on BaseListResponse {
  ApiResult<List<T>> toApiResultList<T>() {
    final List<T> castData = (data)?.cast<T>() ?? <T>[];
    switch(resultCode) {
      case 0:
       return ApiResult<List<T>>.success(
          data: castData,
          resultCode: resultCode,
          failures: failures
        );
      case 1:
        return ApiResult<List<T>>.failure(
            failures: failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شمارخ 096550 تماس بگیرید',
        );
      case 2:
        return ApiResult<List<T>>.failure(
            failures: failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شمارخ 096550 تماس بگیرید',
        );
      case 3:
      case 4:
      return ApiResult<List<T>>.failure(
          failures: failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شمارخ 096550 تماس بگیرید',
      );
      default:
        return ApiResult<List<T>>.failure(
            failures: failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شمارخ 096550 تماس بگیرید',
        );
    }
  }
}
