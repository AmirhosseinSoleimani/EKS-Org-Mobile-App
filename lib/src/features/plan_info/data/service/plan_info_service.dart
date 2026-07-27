import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_cancelation_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_history_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_info_model.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/data/models/plan_lookup_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlanInfoService {
  PlanInfoService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<PlanInfoListModel>> getPlans(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Plan/GetByFilterJson',
      data: body,
    );

    return BaseSingleResponse<PlanInfoListModel>.fromJson(
      response.data ?? {},
      (json) => PlanInfoListModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseSingleResponse<PlanInfoModel>> getPlanById(
    Map<String, dynamic> query,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/Plan/GetById',
      queryParameters: query,
    );

    return BaseSingleResponse<PlanInfoModel>.fromJson(
      response.data ?? {},
      (json) => PlanInfoModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseSingleResponse<String>> createPlan(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Plan/post',
      data: body,
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<String>> editPlan(Map<String, dynamic> body) async {
    final response = await _dio.put<dynamic>(
      '/api/Plan/put',
      data: body,
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<void>> deletePlan(
    Map<String, dynamic> query,
  ) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/api/Plan/DeleteByID',
      queryParameters: query,
    );

    return BaseSingleResponse<void>.fromJson(
      response.data ?? {},
      (_) {},
    );
  }

  Future<BaseListResponse<PlanLookupModel>> getStatusReasons(
    Map<String, dynamic> query,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/Plan/GetReasonsForChangeStatus',
      queryParameters: query,
    );

    return BaseListResponse<PlanLookupModel>.fromJson(
      response.data ?? {},
      (json) => PlanLookupModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseSingleResponse<void>> changeStatus(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Plan/ChangeStatus',
      data: body,
    );

    return BaseSingleResponse<void>.fromJson(
      response.data ?? {},
      (_) {},
    );
  }

  Future<BaseListResponse<PlanInfoModel>> getPlanReport(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Plan/GetPlanInfoReport',
      data: body,
    );

    return BaseListResponse<PlanInfoModel>.fromJson(
      response.data ?? {},
      (json) => PlanInfoModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseSingleResponse<PlanCancelationModel>> cancelAllAssignedRequest(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Plan/CancelAllAssignedRequest',
      data: body,
    );

    return BaseSingleResponse<PlanCancelationModel>.fromJson(
      response.data ?? {},
      (json) => PlanCancelationModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseSingleResponse<PlanLookupListModel>> getEmdadUnits(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnit/GetByFilterJson',
      data: body,
    );

    return _lookupListResponse(response.data);
  }

  Future<BaseSingleResponse<PlanLookupListModel>> getShifts(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Shift/GetByFilterJson',
      data: body,
    );

    return _lookupListResponse(response.data);
  }

  Future<BaseSingleResponse<PlanLookupListModel>> getSpecialPlans(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/SpecialPlan/GetByFilterJson',
      data: body,
    );

    return _lookupListResponse(response.data);
  }

  Future<BaseSingleResponse<PlanLookupListModel>> getLocations(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Location/GetByFilterJson',
      data: body,
    );

    return _lookupListResponse(response.data);
  }

  Future<BaseSingleResponse<void>> changeLocation(
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Plan/ChangeLocation',
      data: body,
    );

    return BaseSingleResponse<void>.fromJson(
      response.data ?? {},
      (_) {},
    );
  }

  Future<BaseListResponse<PlanHistoryModel>> getPlanHistories(
    Map<String, dynamic> query,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/SanHistory/GetSanLogHistoriesById',
      queryParameters: query,
    );

    return BaseListResponse<PlanHistoryModel>.fromJson(
      response.data ?? {},
      (json) => PlanHistoryModel.fromJson(json as Map<String, dynamic>),
    );
  }

  BaseSingleResponse<PlanLookupListModel> _lookupListResponse(
    Map<String, dynamic>? data,
  ) {
    return BaseSingleResponse<PlanLookupListModel>.fromJson(
      data ?? {},
      (json) => PlanLookupListModel.fromJson(json as Map<String, dynamic>),
    );
  }

  BaseSingleResponse<String> _stringMutationResponse(dynamic data) {
    if (data is Map) {
      final json = Map<String, dynamic>.from(data);
      final rawFailures = json['failures'] ?? json['Failures'];
      final failures = rawFailures is List
          ? rawFailures.map((item) => item.toString()).toList()
          : rawFailures?.toString().trim().isNotEmpty == true
              ? <String>[rawFailures.toString()]
              : <String>[];

      return BaseSingleResponse<String>(
        resultCode: _readInt(json['resultCode'] ?? json['ResultCode']) ?? 0,
        data: (json['data'] ?? json['Data'])?.toString() ?? '',
        failures: failures,
      );
    }

    return BaseSingleResponse<String>(
      resultCode: 0,
      data: data?.toString() ?? '',
      failures: const [],
    );
  }

  int? _readInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
