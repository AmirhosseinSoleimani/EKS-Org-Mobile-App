// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_service_evaluation_service.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _HomeServiceEvaluationService implements HomeServiceEvaluationService {
  _HomeServiceEvaluationService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<BaseSingleResponse<EvaluationPostResponseModel?>> postEvaluation(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<EvaluationPostResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/Post',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EvaluationPostResponseModel?> _value;
    try {
      _value = BaseSingleResponse<EvaluationPostResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : EvaluationPostResponseModel.fromJson(
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
  Future<BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel>>
  emdadgarEvaluationAccept(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<
          BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel>
        >(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/EvaluationAccept',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel> _value;
    try {
      _value =
          BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel>.fromJson(
            _result.data!,
            (json) => EmdadgarEvaluationAcceptResponseModel.fromJson(
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
  Future<BaseSingleResponse<EvaluationResponseModel?>>
  getLastEvaluationHomeServices(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<EvaluationResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetLastEvaluation',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<EvaluationResponseModel?> _value;
    try {
      _value = BaseSingleResponse<EvaluationResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : EvaluationResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<DistanceToCustomerResponseModel?>>
  getDistanceToCustomerHomeServices(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<DistanceToCustomerResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetEmdadgarFollowupsDataAndDistances',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<DistanceToCustomerResponseModel?> _value;
    try {
      _value = BaseSingleResponse<DistanceToCustomerResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : DistanceToCustomerResponseModel.fromJson(
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
  Future<BaseListResponse<PartMarkResponseModel?>> getPartMarks(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<BaseListResponse<PartMarkResponseModel?>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/HomeServiceEvaluation/GetPartMarks',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<PartMarkResponseModel?> _value;
    try {
      _value = BaseListResponse<PartMarkResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : PartMarkResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<PartPriceResponseModel?>> getPartPrice(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<PartPriceResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetPartPrice',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<PartPriceResponseModel?> _value;
    try {
      _value = BaseSingleResponse<PartPriceResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : PartPriceResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<ServiceResponseModel?>> getServices(
    Map<String, dynamic> query,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseSingleResponse<ServiceResponseModel?>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/HomeServiceEvaluation/GetServices',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<ServiceResponseModel?> _value;
    try {
      _value = BaseSingleResponse<ServiceResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : ServiceResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<LaborResponseModel?>> getLabors(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<BaseListResponse<LaborResponseModel?>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/HomeServiceEvaluation/GetLabors',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<LaborResponseModel?> _value;
    try {
      _value = BaseListResponse<LaborResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : LaborResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<PartResponseModel?>> getPats(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options = _setStreamType<BaseListResponse<PartResponseModel?>>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/HomeServiceEvaluation/GetParts',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<PartResponseModel?> _value;
    try {
      _value = BaseListResponse<PartResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : PartResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<ReusablePriceResponseModel?>> getReusablePrice(
    Map<String, dynamic> body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<ReusablePriceResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetReusablePrice',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<ReusablePriceResponseModel?> _value;
    try {
      _value = BaseSingleResponse<ReusablePriceResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : ReusablePriceResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseSingleResponse<KilometerFromImageResponseModel?>>
  fetchKilometerImage(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<BaseSingleResponse<KilometerFromImageResponseModel?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetKilometerFromImage',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<KilometerFromImageResponseModel?> _value;
    try {
      _value = BaseSingleResponse<KilometerFromImageResponseModel?>.fromJson(
        _result.data!,
        (json) => json == null
            ? null
            : KilometerFromImageResponseModel.fromJson(
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
  Future<BaseSingleResponse<OcrConfigurationKilometerResponseModel?>>
  fetchOcrConfiguration(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<
          BaseSingleResponse<OcrConfigurationKilometerResponseModel?>
        >(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetOCRConfigurationForKilometer',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<OcrConfigurationKilometerResponseModel?> _value;
    try {
      _value =
          BaseSingleResponse<OcrConfigurationKilometerResponseModel?>.fromJson(
            _result.data!,
            (json) => json == null
                ? null
                : OcrConfigurationKilometerResponseModel.fromJson(
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
  Future<BaseListResponse<ServiceCategoryResponseModel>> getServiceCategories(
    Map<String, dynamic> query,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<BaseListResponse<ServiceCategoryResponseModel>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/HomeServiceEvaluation/GetServiceCategories',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<ServiceCategoryResponseModel> _value;
    try {
      _value = BaseListResponse<ServiceCategoryResponseModel>.fromJson(
        _result.data!,
        (json) =>
            ServiceCategoryResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseListResponse<HomeServicePackageResponseModel>>
  getHomeServicePackage(Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<BaseListResponse<HomeServicePackageResponseModel>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                'api/HomeServiceRequest/GetHomeServicePackage',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<HomeServicePackageResponseModel> _value;
    try {
      _value = BaseListResponse<HomeServicePackageResponseModel>.fromJson(
        _result.data!,
        (json) => HomeServicePackageResponseModel.fromJson(
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
  Future<BaseListResponse<InsertHomeServicePackageResponseModel?>>
  fetchHomeServicePackage(Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<
          BaseListResponse<InsertHomeServicePackageResponseModel?>
        >(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/EmdadgarServiceRequest/GetHomeServicePackage',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseListResponse<InsertHomeServicePackageResponseModel?> _value;
    try {
      _value =
          BaseListResponse<InsertHomeServicePackageResponseModel?>.fromJson(
            _result.data!,
            (json) => json == null
                ? null
                : InsertHomeServicePackageResponseModel.fromJson(
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
  Future<BaseListResponse<InsertHomeServiceCategoryResponseModel>?>
  fetchHomeServiceCategories(Map<String, dynamic> body) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _options =
        _setStreamType<
          BaseListResponse<InsertHomeServiceCategoryResponseModel>?
        >(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/EmdadgarServiceRequest/GetServiceCategories',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BaseListResponse<InsertHomeServiceCategoryResponseModel>? _value;
    try {
      _value = _result.data == null
          ? null
          : BaseListResponse<InsertHomeServiceCategoryResponseModel>.fromJson(
              _result.data!,
              (json) => InsertHomeServiceCategoryResponseModel.fromJson(
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
  Future<BaseSingleResponse<InsertHomeServiceServiceResponseModel?>>
  fetchHomeServiceServices(Map<String, dynamic> query) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<
          BaseSingleResponse<InsertHomeServiceServiceResponseModel?>
        >(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/EmdadgarServiceRequest/GetServices',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseSingleResponse<InsertHomeServiceServiceResponseModel?> _value;
    try {
      _value =
          BaseSingleResponse<InsertHomeServiceServiceResponseModel?>.fromJson(
            _result.data!,
            (json) => json == null
                ? null
                : InsertHomeServiceServiceResponseModel.fromJson(
                    json as Map<String, dynamic>,
                  ),
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
