import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_page_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_person_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/lookup_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

@lazySingleton
class EmdadUnitService {
  EmdadUnitService(this._dio);

  final Dio _dio;

  @POST('/api/EmdadUnit/GetByFilterJson')
  Future<BaseSingleResponse<EmdadUnitPageModel>> getByFilter(
      EmdadUnitFilterRequestModel request,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnit/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseSingleResponse<EmdadUnitPageModel>.fromRootJson(
      response.data ?? {},
      EmdadUnitPageModel.fromJson,
    );
  }

  @GET('/api/EmdadUnit/GetById')
  Future<BaseSingleResponse<EmdadUnitModel>> getById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/EmdadUnit/GetById',
      queryParameters: {'Id': id},
    );
    return BaseSingleResponse<EmdadUnitModel>.fromJson(
      response.data ?? {},
      EmdadUnitModel.fromJson,
    );
  }

  @GET('/api/EmdadUnit/GetEmdadUnitByName')
  Future<BaseListResponse<LookupModel>> getEmdadUnitByName() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/EmdadUnit/GetEmdadUnitByName',
    );
    return BaseListResponse<LookupModel>.fromJson(
      response.data ?? {},
      LookupModel.fromJson,
    );
  }

  @POST('/api/EmdadUnit/Post')
  Future<BaseSingleResponse<EmdadUnitModel>> create(
      Map<String, dynamic> body,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnit/Post',
      data: body,
    );
    return BaseSingleResponse<EmdadUnitModel>.fromJson(
      response.data ?? {},
      EmdadUnitModel.fromJson,
    );
  }

  @PUT('/api/EmdadUnit/Put')
  Future<BaseSingleResponse<EmdadUnitModel>> update(
      Map<String, dynamic> body,
      ) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/api/EmdadUnit/Put',
      data: body,
    );
    return BaseSingleResponse<EmdadUnitModel>.fromJson(
      response.data ?? {},
      EmdadUnitModel.fromJson,
    );
  }

  @POST('/api/EmdadUnit/UpdateImage')
  Future<BaseSingleResponse<EmdadUnitModel>> updateImage(
      Map<String, dynamic> body,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnit/UpdateImage',
      data: body,
    );
    return BaseSingleResponse<EmdadUnitModel>.fromJson(
      response.data ?? {},
      EmdadUnitModel.fromJson,
    );
  }

  @DELETE('/api/EmdadUnit/DeleteByID')
  Future<BaseResponse> deleteById(int id) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/api/EmdadUnit/DeleteByID',
      queryParameters: {'id': id},
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  @POST('/api/EmdadUnitPerson/Post')
  Future<BaseResponse> assignPerson(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnitPerson/Post',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  @POST('/api/EmdadUnitPerson/GetByFilterJson')
  Future<BaseListResponse<EmdadUnitPersonModel>> getPersons(
      EmdadUnitFilterRequestModel request,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnitPerson/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseListResponse<EmdadUnitPersonModel>.fromJson(
      response.data ?? {},
      EmdadUnitPersonModel.fromJson,
    );
  }

  @DELETE('/api/EmdadUnitPerson/DeleteByID')
  Future<BaseResponse> deletePersonById(int id) async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/api/EmdadUnitPerson/DeleteByID',
      queryParameters: {'id': id},
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  @GET('/api/Depot/GetDepotGroupedByMarkAndSerialByVehicleId')
  Future<BaseListResponse<LookupModel>> getDepotGroupedParts(
      int vehicleInfoId,
      ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/Depot/GetDepotGroupedByMarkAndSerialByVehicleId',
      queryParameters: {'VehicleInfoID': vehicleInfoId},
    );
    return BaseListResponse<LookupModel>.fromJson(
      response.data ?? {},
      LookupModel.fromJson,
    );
  }

  @POST('/api/Depot/TransferDepotByVehicleId')
  Future<BaseResponse> transferDepotByVehicleId(
      Map<String, dynamic> body,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Depot/TransferDepotByVehicleId',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  @POST('/api/EmdadUnit/ChangeLocation')
  Future<BaseResponse> changeLocation(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/EmdadUnit/ChangeLocation',
      data: body,
    );
    return BaseResponse.fromJson(response.data ?? {});
  }

  @POST('/api/AgencyInfo/GetByFilterJson')
  Future<BaseListResponse<LookupModel>> getAgencies(
      EmdadUnitFilterRequestModel request,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/AgencyInfo/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseListResponse<LookupModel>.fromJson(
      response.data ?? {},
      LookupModel.fromJson,
    );
  }

  @POST('/api/AgencyPerson/GetByFilterJson')
  Future<BaseListResponse<LookupModel>> getAgencyPersons(
      EmdadUnitFilterRequestModel request,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/AgencyPerson/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseListResponse<LookupModel>.fromJson(
      response.data ?? {},
      LookupModel.fromJson,
    );
  }

  @POST('/api/AgencyVehicle/GetByFilterJson')
  Future<BaseListResponse<LookupModel>> getAgencyVehicles(
      EmdadUnitFilterRequestModel request,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/AgencyVehicle/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseListResponse<LookupModel>.fromJson(
      response.data ?? {},
      LookupModel.fromJson,
    );
  }

  @POST('/api/Location/GetByFilterJson')
  Future<BaseListResponse<LookupModel>> getLocations(
      EmdadUnitFilterRequestModel request,
      ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/Location/GetByFilterJson',
      data: request.toJson(),
    );
    return BaseListResponse<LookupModel>.fromJson(
      response.data ?? {},
      LookupModel.fromJson,
    );
  }
}
