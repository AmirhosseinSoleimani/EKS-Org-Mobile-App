import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess(String error,
      {StackTrace? stackTrace}) = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(error, StackTrace? stackTrace) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions =
            const NetworkExceptions.unexpectedError();
        if (error is DioException) {
          log(error.toString());
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = _handleResponse(error.response);
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.serviceUnavailable();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = _handleConnectionError(error);
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.serviceUnavailable();
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.serviceUnavailable();
              break;
            default:
              networkExceptions = const NetworkExceptions.unexpectedError();
          }
        } else if (error is SocketException) {
          final message = error.toString().toLowerCase();
          networkExceptions = _isOfflineSocketError(message)
              ? const NetworkExceptions.noInternetConnection()
              : const NetworkExceptions.serviceUnavailable();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        // Helper.printError(e.toString());
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess(error.toString(),
            stackTrace: stackTrace);
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static NetworkExceptions _handleConnectionError(DioException error) {
    final innerError = error.error;
    final message = '${error.message} ${innerError ?? ''}'.toLowerCase();

    if (_isOfflineSocketError(message)) {
      return const NetworkExceptions.noInternetConnection();
    }

    return const NetworkExceptions.serviceUnavailable();
  }

  static bool _isOfflineSocketError(String message) {
    return message.contains('failed host lookup') ||
        message.contains('network is unreachable') ||
        message.contains('no address associated with hostname') ||
        message.contains('nodename nor servname provided') ||
        message.contains('temporary failure in name resolution');
  }

  static NetworkExceptions _handleResponse(Response<dynamic>? response) {
    switch (response?.statusCode) {
      case 400:
        return const NetworkExceptions.badRequest();
      case 401:
      case 403:
        return const NetworkExceptions.unauthorisedRequest();
      case 404:
        return const NetworkExceptions.notFound('سرویس موردنظر یافت نشد');
      case 405:
        return const NetworkExceptions.methodNotAllowed();
      case 409:
        return const NetworkExceptions.conflict();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 502:
      case 503:
      case 504:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return const NetworkExceptions.unexpectedError();
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    //TODO handel error server msg
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "Not Implemented";
    }, requestCancelled: () {
      errorMessage = "Request Cancelled";
    }, internalServerError: () {
      errorMessage = "خطای داخلی سرور رخ داده است";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "سرویس در حال حاضر در دسترس نیست. لطفا کمی بعد دوباره تلاش کنید";
    }, methodNotAllowed: () {
      errorMessage = "Method Allowed";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorisedRequest: () {
      errorMessage = "خطای دسترسی";
    }, unexpectedError: () {
      errorMessage = "خطای غیرمنتظره";
    }, requestTimeout: () {
      errorMessage = "پاسخی از سرور دریافت نشد. لطفا کمی بعد دوباره تلاش کنید";
    }, noInternetConnection: () {
      errorMessage =
          "خطای عدم دسترسی به اینترنت، از دسترسی به اینترنت مطمئن شوید و دوباره تلاش نمائید";
    }, conflict: () {
      errorMessage = "Error due to a conflict";
    }, sendTimeout: () {
      errorMessage = "ارسال درخواست به سرویس انجام نشد. لطفا کمی بعد دوباره تلاش کنید";
    }, unableToProcess: (e, stacktrace) {
      log(stacktrace.toString());
      errorMessage = "پردازش اطلاعات امکانپذیر نیست";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Unexpected error occurred";
    }, notAcceptable: () {
      errorMessage = "Not acceptable";
    });
    return errorMessage;
  }
}
