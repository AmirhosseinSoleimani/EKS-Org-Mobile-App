import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_contract_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_info_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_person_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_person_response_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_vehicle_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_vehicle_response_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_additional_information_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_contract_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_contract_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_history_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_history_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_report_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_person_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_service_type_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_vehicle_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/change_agency_status_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/delete_agency_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/person_info_search_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/person_info_search_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/vehicle_info_search_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/vehicle_info_search_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AgencyInfoService {
  AgencyInfoService(this._dio);

  final Dio _dio;

  Future<AgencyInfoPageModel> getByFilter(
    AgencyInfoFilterRequestModel request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/AgencyInfo/GetByFilterJson',
      data: request.toJson(),
    );

    return AgencyInfoPageModel.fromJson(response.data ?? {});
  }

  Future<BaseSingleResponse<AgencyInfoModel>> getById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/AgencyInfo/GetById',
      queryParameters: {'Id': id},
    );

    return BaseSingleResponse<AgencyInfoModel>.fromJson(
      response.data ?? {},
      AgencyInfoModel.fromJson,
    );
  }

  Future<BaseListResponse<AgencyInfoModel>> getByName(String title) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/AgencyInfo/GetAgencyByName',
      queryParameters: {'Title': title},
    );

    return BaseListResponse<AgencyInfoModel>.fromJson(
      response.data ?? {},
      AgencyInfoModel.fromJson,
    );
  }

  Future<BaseSingleResponse<String>> addAgency(
    AddAgencyInfoRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyInfo/post',
      data: request.toJson(),
    );

    final data = response.data;
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

  Future<BaseSingleResponse<String>> addContract(
    AddAgencyContractRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyContract/post',
      data: request.toJson(),
    );

    return _stringMutationResponse(response.data);
  }

  Future<BaseSingleResponse<AddAgencyPersonResponseModel>> addPerson(
    AddAgencyPersonRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyPerson/post',
      data: request.toJson(),
    );

    return _addAgencyPersonMutationResponse(response.data);
  }
  Future<BaseSingleResponse<AddAgencyVehicleResponseModel>> addVehicle(
      AddAgencyVehicleRequestModel request,
      ) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyVehicle/post',
      data: request.toJson(),
    );

    return _addAgencyVehicleMutationResponse(response.data);
  }

  BaseSingleResponse<AddAgencyVehicleResponseModel>
  _addAgencyVehicleMutationResponse(dynamic data) {
    if (data is Map) {
      final json = Map<String, dynamic>.from(data);
      final rawFailures = json['failures'] ?? json['Failures'];
      final failures = rawFailures is List
          ? rawFailures.map((item) => item.toString()).toList()
          : rawFailures?.toString().trim().isNotEmpty == true
          ? <String>[rawFailures.toString()]
          : <String>[];

      return BaseSingleResponse<AddAgencyVehicleResponseModel>(
        resultCode: _readInt(json['resultCode'] ?? json['ResultCode']) ?? 0,
        data: AddAgencyVehicleResponseModel.fromResponse(json),
        failures: failures,
      );
    }

    return BaseSingleResponse<AddAgencyVehicleResponseModel>(
      resultCode: 0,
      data: AddAgencyVehicleResponseModel.fromResponse(data),
      failures: const [],
    );
  }

  Future<AgencyContractPageModel> getContracts(
      AgencyContractFilterRequestModel request,) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyContract/GetByFilterJson',
      data: request.toJson(),
    );

    return AgencyContractPageModel.fromJson(
        _normalizePageResponse(response.data));
  }

  Future<AgencyPersonPageModel> getCurrentPersons(
      AgencyInfoIdRequestModel request,) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyPerson/GetByFilterJson',
      data: request.toFilterJson(),
    );

    return AgencyPersonPageModel.fromJson(
        _normalizePageResponse(response.data));
  }

  Future<PersonInfoSearchPageModel> searchPersons(
      PersonInfoSearchRequestModel request,) async {
    final response = await _dio.post<dynamic>(
      '/api/PersonInfo/GetByFilterJson',
      data: request.toJson(),
    );

    return PersonInfoSearchPageModel.fromJson(
        _normalizePageResponse(response.data));
  }

  Future<AgencyVehiclePageModel> getCurrentVehicles(
      AgencyInfoIdRequestModel request,) async {
    final response = await _dio.post<dynamic>(
      '/api/AgencyVehicle/GetByFilterJson',
      data: request.toFilterJson(),
    );

    return AgencyVehiclePageModel.fromJson(
        _normalizePageResponse(response.data));
  }

  Future<VehicleInfoSearchPageModel> searchVehicles(
      VehicleInfoSearchRequestModel request,) async {
    final response = await _dio.post<dynamic>(
      '/api/VehicleInfo/GetByFilterJson',
      data: request.toJson(),
    );

    return VehicleInfoSearchPageModel.fromJson(
        _normalizePageResponse(response.data));
  }

  Future<void> changeStatus(ChangeAgencyStatusRequestModel request) async {
    await _dio.put<dynamic>(
      '/api/AgencyInfo/ChangeStatus',
      queryParameters: request.toQueryParameters(),
      data: request.toJson(),
    );
  }

  Future<BaseSingleResponse<void>> deleteAgency(
    DeleteAgencyRequestModel request,
  ) async {
    final response = await _dio.delete<dynamic>(
      '/api/AgencyInfo/DeleteByID',
      queryParameters: request.toQueryParameters(),
    );

    final data = response.data;
    if (data is Map) {
      final json = Map<String, dynamic>.from(data);
      final rawFailures = json['failures'] ?? json['Failures'];
      final failures = rawFailures is List
          ? rawFailures.map((item) => item.toString()).toList()
          : rawFailures?.toString().trim().isNotEmpty == true
              ? <String>[rawFailures.toString()]
              : <String>[];

      return BaseSingleResponse<void>(
        resultCode: _readInt(json['resultCode'] ?? json['ResultCode']) ?? 0,
        failures: failures,
      );
    }

    return BaseSingleResponse<void>(
      resultCode: 0,
      failures: const [],
    );
  }

  Future<BaseListResponse<AgencyServiceTypeModel>> getServiceTypes(
      AgencyIdRequestModel request,) async {
    final response = await _dio.get<dynamic>(
      '/api/AgencyInfo/GetServiceTypes',
      queryParameters: request.toJson(),
    );

    return BaseListResponse<AgencyServiceTypeModel>.fromJson(
      _normalizeListResponse(response.data),
      AgencyServiceTypeModel.fromJson,
    );
  }

  Future<BaseSingleResponse<AgencyAdditionalInformationModel>>
  getAdditionalInformation(AgencyInfoIdRequestModel request) async {
    final response = await _dio.get<dynamic>(
      '/api/AgencyInfo/GetAdditionalInformation',
      queryParameters: request.toJson(),
    );

    return BaseSingleResponse<AgencyAdditionalInformationModel>.fromJson(
      _normalizeSingleResponse(response.data),
      AgencyAdditionalInformationModel.fromJson,
    );
  }

  Future<BaseListResponse<AgencyHistoryModel>> getHistory(
      AgencyHistoryRequestModel request,) async {
    final response = await _dio.get<dynamic>(
      '/api/SanHistory/GetSanLogHistoriesById',
      queryParameters: request.toJson(),
    );

    return BaseListResponse<AgencyHistoryModel>.fromJson(
      _normalizeListResponse(response.data),
      AgencyHistoryModel.fromJson,
    );
  }

  Map<String, dynamic> _normalizePageResponse(dynamic data) {
    if (data is List) {
      return {
        'data': {
          'records': data,
          'count': data.length,
        },
      };
    }

    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      final hasEnvelope = mappedData.containsKey('data') ||
          mappedData.containsKey('Data') ||
          mappedData.containsKey('records') ||
          mappedData.containsKey('Records') ||
          mappedData.containsKey('resultCode') ||
          mappedData.containsKey('ResultCode') ||
          mappedData.containsKey('message') ||
          mappedData.containsKey('Message') ||
          mappedData.containsKey('failures') ||
          mappedData.containsKey('Failures');

      if (hasEnvelope) {
        return mappedData;
      }

      return {
        'data': {
          'records': [mappedData],
          'count': 1,
        },
      };
    }

    return const <String, dynamic>{};
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

  BaseSingleResponse<AddAgencyPersonResponseModel>
      _addAgencyPersonMutationResponse(
    dynamic data,
  ) {
    final response = _stringMutationResponse(data);

    return BaseSingleResponse<AddAgencyPersonResponseModel>(
      resultCode: response.resultCode,
      data: AddAgencyPersonResponseModel(id: response.data ?? ''),
      failures: response.failures,
    );
  }

  Map<String, dynamic> _normalizeListResponse(dynamic data) {
    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      if (mappedData.containsKey('data') ||
          mappedData.containsKey('Data') ||
          mappedData.containsKey('resultCode') ||
          mappedData.containsKey('ResultCode')) {
        return mappedData;
      }
    }

    return {
      'resultCode': 0,
      'data': data is List
          ? data
          : data is Map
          ? [Map<String, dynamic>.from(data)]
          : <dynamic>[],
    };
  }

  Map<String, dynamic> _normalizeSingleResponse(dynamic data) {
    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      if (mappedData.containsKey('data') ||
          mappedData.containsKey('Data') ||
          mappedData.containsKey('resultCode') ||
          mappedData.containsKey('ResultCode')) {
        return mappedData;
      }

      return {
        'resultCode': 0,
        'data': mappedData,
      };
    }

    return {
      'resultCode': 0,
      'data': null,
    };
  }

  int? _readInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  Future<AgencyInfoReportModel> getReport(
    AgencyInfoFilterRequestModel request,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/AgencyInfo/GetByFilterJson',
      data: request.toJson(),
    );

    return AgencyInfoReportModel.fromJson(response.data ?? {});
  }

}
