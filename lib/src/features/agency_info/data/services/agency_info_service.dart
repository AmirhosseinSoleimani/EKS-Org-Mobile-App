import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_page_model.dart';
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
}
