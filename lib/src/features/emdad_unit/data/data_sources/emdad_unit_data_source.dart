import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_page_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_person_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/lookup_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class EmdadUnitDataSource {
  Future<BaseSingleResponse<EmdadUnitPageModel>> getByFilter(EmdadUnitFilterRequestModel request);
  Future<BaseSingleResponse<EmdadUnitModel>> getById(int id);
  Future<BaseSingleResponse<EmdadUnitModel>> create(Map<String, dynamic> body);
  Future<BaseSingleResponse<EmdadUnitModel>> update(Map<String, dynamic> body);
  Future<BaseSingleResponse<EmdadUnitModel>> updateImage(Map<String, dynamic> body);
  Future<BaseResponse> deleteById(int id);
  Future<BaseListResponse<EmdadUnitPersonModel>> getPersons(EmdadUnitFilterRequestModel request);
  Future<BaseResponse> assignPerson(Map<String, dynamic> body);
  Future<BaseResponse> deletePersonById(int id);
  Future<BaseResponse> changeLocation(Map<String, dynamic> body);
  Future<BaseListResponse<LookupModel>> getAgencies(EmdadUnitFilterRequestModel request);
  Future<BaseListResponse<LookupModel>> getAgencyPersons(EmdadUnitFilterRequestModel request);
  Future<BaseListResponse<LookupModel>> getAgencyVehicles(EmdadUnitFilterRequestModel request);
  Future<BaseListResponse<LookupModel>> getLocations(EmdadUnitFilterRequestModel request);
}
