import 'package:dio/dio.dart';

/// Cancels an older interactive list/filter request when a newer request for
/// the same endpoint starts.
///
/// Only read/list endpoints that are intentionally safe to replace are opted
/// in. Bulk/export requests use a separate request group and are not cancelled
/// by normal list filtering.
class LatestRequestCancellationInterceptor extends Interceptor {
  static const _requestKeyExtra = 'latestRequestCancellationKey';

  static const Set<String> _replaceablePaths = <String>{
    '/api/agencyinfo/getbyfilterjson',
    '/api/location/getbyfilterjson',
    '/api/emdadunit/getbyfilterjson',
    '/api/generalcontent/getbyfilterjson',
    '/api/gradepattern/getbyfilterjson',
    '/api/imeiinfo/getbyfilterjson',
    '/api/invoiceagencyobjection/getbyfilterjson',
    '/api/invoice/reportcustomerpreinvoice',
    '/api/invoice/reportcustomerinvoice',
    '/api/invoice/reportemdadgarpreinvoice',
    '/api/invoice/reportemdadgarinvoice',
    '/api/invoice/reportemdadgaramaliatfinalinvoice',
    '/api/invoice/reportemdadgarfinalinvoice',
    '/api/invoice/reportemdadgardefiniteinvoice',
    '/api/staffleave/getleavereports',
    '/api/plan/getbyfilterjson',
    '/api/personinfo/getbyfilterjson',
    '/api/aidservicerequest/getbyfilterjson',
    '/api/homeservicerequest/getbyfilterjson',
    '/api/emdadgar/getemdadgarlist',
    '/api/shift/getbyfilterjson',
    '/api/skillcertificate/getbyfilterjson',
    '/api/specialplaninfo/getbyfilterjson',
    '/api/vehicleinfo/getbyfilterjson',
    '/api/vehiclemodel/getbyfilterjson',
  };

  final Map<String, CancelToken> _activeTokens = <String, CancelToken>{};

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (!_isReplaceableRequest(options)) {
      handler.next(options);
      return;
    }

    final key = _buildKey(options);
    final currentToken = options.cancelToken ?? CancelToken();
    final previousToken = _activeTokens[key];

    if (previousToken != null &&
        previousToken != currentToken &&
        !previousToken.isCancelled) {
      previousToken.cancel('Superseded by a newer request.');
    }

    options.cancelToken = currentToken;
    options.extra[_requestKeyExtra] = key;
    _activeTokens[key] = currentToken;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _release(response.requestOptions);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _release(err.requestOptions);
    handler.next(err);
  }

  bool _isReplaceableRequest(RequestOptions options) {
    return _replaceablePaths.contains(options.path.toLowerCase());
  }

  String _buildKey(RequestOptions options) {
    final pageSize = _readPageSize(options.data) ??
        _readPageSize(options.queryParameters);
    final requestGroup = pageSize == 0
        ? 'search'
        : pageSize is num && pageSize >= 1000
            ? 'bulk'
            : 'interactive';
    return '${options.method.toUpperCase()}:${options.path}:$requestGroup';
  }

  Object? _readPageSize(Object? value) {
    if (value is! Map) return null;
    for (final entry in value.entries) {
      if (entry.key.toString().toLowerCase() == 'pagesize') {
        return entry.value;
      }
    }
    return null;
  }

  void _release(RequestOptions options) {
    final key = options.extra[_requestKeyExtra];
    if (key is! String) return;

    final activeToken = _activeTokens[key];
    if (identical(activeToken, options.cancelToken)) {
      _activeTokens.remove(key);
    }
  }
}
