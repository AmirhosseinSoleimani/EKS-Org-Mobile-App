import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_page_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_product_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpecialPlanService {
  SpecialPlanService(this._dio);

  final Dio _dio;

  Options get _jsonOptions => Options(contentType: Headers.jsonContentType);

  Future<BaseSingleResponse<SpecialPlanPageModel>> getByFilter(
    SpecialPlanFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/SpecialPlanInfo/GetByFilterJson',
      data: request.toJson(),
      options: _jsonOptions,
    );
    final root = _root(response.data);
    return BaseSingleResponse<SpecialPlanPageModel>(
      resultCode: _resultCode(root),
      data: SpecialPlanPageModel.fromResponse(response.data),
      failures: _failures(root),
    );
  }

  Future<BaseSingleResponse<List<SpecialPlanProductModel>>>
      getProducts() async {
    final response = await _dio.post<dynamic>(
      '/api/EmdadProduct/GetByFilterJson',
      data: const {
        'Sort': <dynamic>[],
        'Filter': {
          'Logic': 'and',
          'Filters': <dynamic>[],
        },
      },
      options: _jsonOptions,
    );
    final root = _root(response.data);
    final products = SpecialPlanJsonHelper.records(response.data)
        .whereType<Map>()
        .map(
          (item) => SpecialPlanProductModel.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .where((item) => item.id > 0 && item.title.isNotEmpty)
        .toList(growable: false);
    return BaseSingleResponse<List<SpecialPlanProductModel>>(
      resultCode: _resultCode(root),
      data: products,
      failures: _failures(root),
    );
  }

  Future<BaseSingleResponse<String>> create(
    SpecialPlanFormRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/SpecialPlanInfo/InsertSpecialPlanWithZones',
      data: request.toCreateJson(),
      options: _jsonOptions,
    );
    return _mutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> update(
    SpecialPlanFormRequestModel request,
  ) async {
    final response = await _dio.put<dynamic>(
      '/api/SpecialPlanInfo/put',
      data: request.toUpdateJson(),
      options: _jsonOptions,
    );
    return _mutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> deleteById(
    SpecialPlanIdRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/SpecialPlanInfo/DeleteByID',
      queryParameters: request.toDeleteJson(),
      options: _jsonOptions,
    );
    return _mutationResponse(response.data);
  }

  BaseSingleResponse<String> _mutationResponse(dynamic raw) {
    final root = _root(raw);
    final data = root.isEmpty
        ? raw?.toString() ?? ''
        : (root['data'] ?? root['Data'])?.toString() ?? '';
    return BaseSingleResponse<String>(
      resultCode: _resultCode(root),
      data: data,
      failures: _failures(root),
    );
  }

  Map<String, dynamic> _root(dynamic raw) {
    return raw is Map
        ? Map<String, dynamic>.from(raw)
        : const <String, dynamic>{};
  }

  int _resultCode(Map<String, dynamic> json) =>
      SpecialPlanJsonHelper.integer(
        json['resultCode'] ?? json['ResultCode'],
      ) ??
      0;

  List<String> _failures(Map<String, dynamic> json) {
    final raw = json['failures'] ?? json['Failures'];
    final message = json['message'] ?? json['Message'];
    if (raw is List) {
      return raw
          .map((item) => item.toString())
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false);
    }
    if (raw?.toString().trim().isNotEmpty == true) {
      return [raw.toString()];
    }
    if (message?.toString().trim().isNotEmpty == true) {
      return [message.toString()];
    }
    return const [];
  }
}
