// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _RequestService implements RequestService {
  _RequestService(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  });

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList(
      Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseListResponse<ReliefRequestModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/AidServiceRequestOrg/GetAidServiceRequestList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<ReliefRequestModel> _value;
    try {
      _value = BaseListResponse<ReliefRequestModel>.fromJson(
        _result.data!,
        (json) => ReliefRequestModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<BaseSingleResponse<ReliefRequestModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/AidServiceRequestOrg/GetAidServiceRequestById',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<ReliefRequestModel> _value;
    try {
      _value = BaseSingleResponse<ReliefRequestModel>.fromJson(
        _result.data!,
        (json) => ReliefRequestModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList(
      Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseListResponse<HomeServiceRequestModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/HomeServiceRequestOrg/GetHomeServiceRequestList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<HomeServiceRequestModel> _value;
    try {
      _value = BaseListResponse<HomeServiceRequestModel>.fromJson(
        _result.data!,
        (json) =>
            HomeServiceRequestModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<BaseSingleResponse<HomeServiceRequestModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/HomeServiceRequestOrg/GetServiceRequest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<HomeServiceRequestModel> _value;
    try {
      _value = BaseSingleResponse<HomeServiceRequestModel>.fromJson(
        _result.data!,
        (json) =>
            HomeServiceRequestModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseSingleResponse<NonCooperationListModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/LackOfCooperationOrg/getLackOfCooperationList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<NonCooperationListModel> _value;
    try {
      _value = BaseSingleResponse<NonCooperationListModel>.fromJson(
        _result.data!,
        (json) =>
            NonCooperationListModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<CartableCycleItemModel>> getCartableCycleList(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseListResponse<CartableCycleItemModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/CartableOrg/GetServiceRequestMessageFlow',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<CartableCycleItemModel> _value;
    try {
      _value = BaseListResponse<CartableCycleItemModel>.fromJson(
        _result.data!,
        (json) => CartableCycleItemModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<EvaluationHistoryItemModel>> getEvaluationHistory(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseListResponse<EvaluationHistoryItemModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/AidServiceEvaluationOrg/GetEvaluationsByServiceRequestId',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<EvaluationHistoryItemModel> _value;
    try {
      _value = BaseListResponse<EvaluationHistoryItemModel>.fromJson(
        _result.data!,
        (json) =>
            EvaluationHistoryItemModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<RequestStatusHistoryListModel>>
      getRequestStatusHistory(Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseSingleResponse<RequestStatusHistoryListModel>>(
            Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/api/ServiceRequestHistoryOrg/GetByFilterJson',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<RequestStatusHistoryListModel> _value;
    try {
      _value = BaseSingleResponse<RequestStatusHistoryListModel>.fromJson(
        _result.data!,
        (json) => RequestStatusHistoryListModel.fromJson(
            json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<EmdadgarInfoModel>> getEmdadgarInfo(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseSingleResponse<EmdadgarInfoModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/EmdadgarOrg/GetEmdadgarByServiceRequestId',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EmdadgarInfoModel> _value;
    try {
      _value = BaseSingleResponse<EmdadgarInfoModel>.fromJson(
        _result.data!,
        (json) => EmdadgarInfoModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<EmdadgarInfoModel>> getRequestFollowUp(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseSingleResponse<EmdadgarInfoModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/RequestFollowUpOrg/GetByFilterJson',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EmdadgarInfoModel> _value;
    try {
      _value = BaseSingleResponse<EmdadgarInfoModel>.fromJson(
        _result.data!,
        (json) => EmdadgarInfoModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<ChassisRequestHistoryModel>>
      getChassisRequestHistoryList(Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseListResponse<ChassisRequestHistoryModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/CustomerViewAllOrg/GetServiceRequests',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<ChassisRequestHistoryModel> _value;
    try {
      _value = BaseListResponse<ChassisRequestHistoryModel>.fromJson(
        _result.data!,
        (json) =>
            ChassisRequestHistoryModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<ControlInfoModel>> getControlInfo(
      Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query);
    final _options =
        _setStreamType<BaseSingleResponse<ControlInfoModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/RequestFollowUp/ServiceRequestsFollowUpByUser',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<ControlInfoModel> _value;
    try {
      _value = BaseSingleResponse<ControlInfoModel>.fromJson(
        _result.data!,
        (json) => ControlInfoModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
