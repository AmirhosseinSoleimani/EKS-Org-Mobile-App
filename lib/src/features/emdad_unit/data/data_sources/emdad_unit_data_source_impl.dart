import 'package:eks_sana_plus_org/src/features/emdad_unit/data/data_sources/emdad_unit_data_source.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_page_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_person_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/lookup_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/services/emdad_unit_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmdadUnitDataSource)
class EmdadUnitDataSourceImpl extends EmdadUnitDataSource {
  EmdadUnitDataSourceImpl(this._service);

  final EmdadUnitService _service;

  @override
  Future<BaseSingleResponse<EmdadUnitPageModel>> getByFilter(EmdadUnitFilterRequestModel request) {
    return _service.getByFilter(request);
  }

  @override
  Future<BaseSingleResponse<EmdadUnitModel>> getById(int id) => _service.getById(id);

  @override
  Future<BaseSingleResponse<EmdadUnitModel>> create(Map<String, dynamic> body) => _service.create(body);

  @override
  Future<BaseSingleResponse<EmdadUnitModel>> update(Map<String, dynamic> body) => _service.update(body);

  @override
  Future<BaseSingleResponse<EmdadUnitModel>> updateImage(Map<String, dynamic> body) => _service.updateImage(body);

  @override
  Future<BaseResponse> deleteById(int id) => _service.deleteById(id);

  @override
  Future<BaseListResponse<EmdadUnitPersonModel>> getPersons(EmdadUnitFilterRequestModel request) {
    return _service.getPersons(request);
  }

  @override
  Future<BaseResponse> assignPerson(Map<String, dynamic> body) => _service.assignPerson(body);

  @override
  Future<BaseResponse> deletePersonById(int id) => _service.deletePersonById(id);

  @override
  Future<BaseResponse> changeLocation(Map<String, dynamic> body) => _service.changeLocation(body);

  @override
  Future<BaseListResponse<LookupModel>> getAgencies(EmdadUnitFilterRequestModel request) => _service.getAgencies(request);

  @override
  Future<BaseListResponse<LookupModel>> getAgencyPersons(EmdadUnitFilterRequestModel request) {
    return _service.getAgencyPersons(request);
  }

  @override
  Future<BaseListResponse<LookupModel>> getAgencyVehicles(EmdadUnitFilterRequestModel request) {
    return _service.getAgencyVehicles(request);
  }

  @override
  Future<BaseListResponse<LookupModel>> getLocations(EmdadUnitFilterRequestModel request) {
    return _service.getLocations(request);
  }
}
