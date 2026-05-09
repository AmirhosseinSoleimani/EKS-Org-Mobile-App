// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation_service.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _EvaluationService implements EvaluationService {
  _EvaluationService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<BaseListResponse<DefectModel?>> getDefectsList(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<BaseListResponse<DefectModel?>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/DefectOrg/GetListOfDefects',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<DefectModel?> _value;
    try {
      _value = BaseListResponse<DefectModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : DefectModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<ServiceCategoryModel>> getAidServiceCategories(
    Map<String, dynamic> query,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseListResponse<ServiceCategoryModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/AidServiceEvaluationOrg/GetServiceCategories',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<ServiceCategoryModel> _value;
    try {
      _value = BaseListResponse<ServiceCategoryModel>.fromJson(
        _result.data!,
        (json) => ServiceCategoryModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<ServiceCategoryModel>> getHomeServiceCategories(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(body);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseListResponse<ServiceCategoryModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/HomeServiceEvaluationOrg/GetServiceCategories',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<ServiceCategoryModel> _value;
    try {
      _value = BaseListResponse<ServiceCategoryModel>.fromJson(
        _result.data!,
        (json) => ServiceCategoryModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<ServiceResponseModel>> getAidServices(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(body);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseSingleResponse<ServiceResponseModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/AidServiceEvaluationOrg/GetServices',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<ServiceResponseModel> _value;
    try {
      _value = BaseSingleResponse<ServiceResponseModel>.fromJson(
        _result.data!,
        (json) => ServiceResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<PostEvaluationResponseModel>>
  aidServiceEvaluationPost(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<PostEvaluationResponseModel>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/AidServiceEvaluationOrg/post',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<PostEvaluationResponseModel> _value;
    try {
      _value = BaseSingleResponse<PostEvaluationResponseModel>.fromJson(
        _result.data!,
        (json) =>
            PostEvaluationResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<PostEvaluationResponseModel>>
  homeServiceEvaluationPost(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<PostEvaluationResponseModel>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluationOrg/post',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<PostEvaluationResponseModel> _value;
    try {
      _value = BaseSingleResponse<PostEvaluationResponseModel>.fromJson(
        _result.data!,
        (json) =>
            PostEvaluationResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>>
  aidEvaluationAccept(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<AcceptEvaluationResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/AidServiceEvaluationOrg/EvaluationAccept',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<AcceptEvaluationResponseModel?> _value;
    try {
      _value = BaseSingleResponse<AcceptEvaluationResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : AcceptEvaluationResponseModel.fromJson(
                json as Map<String, dynamic>,
              ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>>
  homeServiceEvaluationAccept(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<AcceptEvaluationResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluationOrg/EvaluationAccept',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<AcceptEvaluationResponseModel?> _value;
    try {
      _value = BaseSingleResponse<AcceptEvaluationResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : AcceptEvaluationResponseModel.fromJson(
                json as Map<String, dynamic>,
              ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<EmdadgarServiceDetailModel>>
  getAidServiceDetailAndCheckSubscriptionForEmdagarEvaluation(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<BaseSingleResponse<EmdadgarServiceDetailModel>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/AidServiceEvaluationOrg/GetServiceDetailAndCheckSubscriptionForEmdagarEvaluation',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EmdadgarServiceDetailModel> _value;
    try {
      _value = BaseSingleResponse<EmdadgarServiceDetailModel>.fromJson(
        _result.data!,
        (json) =>
            EmdadgarServiceDetailModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<EmdadgarServiceDetailModel>>
  getHomeServiceDetailAndCheckSubscriptionForEmdagarEvaluation(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<BaseSingleResponse<EmdadgarServiceDetailModel>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/HomeServiceEvaluationOrg/GetServiceDetailAndCheckSubscriptionForEmdagarEvaluation',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EmdadgarServiceDetailModel> _value;
    try {
      _value = BaseSingleResponse<EmdadgarServiceDetailModel>.fromJson(
        _result.data!,
        (json) =>
            EmdadgarServiceDetailModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
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

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
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

// dart format on
