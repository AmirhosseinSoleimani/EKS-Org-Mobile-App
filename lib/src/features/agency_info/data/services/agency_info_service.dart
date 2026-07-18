import 'package:dio/dio.dart';
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
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_person_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_service_type_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_vehicle_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/change_agency_status_request_model.dart';
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
          mappedData.containsKey('Records');

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

}
