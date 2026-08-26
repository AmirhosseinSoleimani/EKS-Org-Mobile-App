import 'package:eks_sana_plus_org/src/features/emdad_unit/data/data_sources/emdad_unit_data_source.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/assign_emdad_unit_person_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/create_emdad_unit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/update_emdad_unit_image_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/repositories/emdad_unit_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmdadUnitRepository)
class EmdadUnitRepositoryImpl extends EmdadUnitRepository {
  EmdadUnitRepositoryImpl(this._dataSource);

  final EmdadUnitDataSource _dataSource;

  @override
  Future<ApiResult<EmdadUnitPageEntity>> getByFilter(
      EmdadUnitFilterParamEntity param,
      ) async {
    try {
      final result = await _dataSource.getByFilter(param.toModel());
      return result.toApiResult<EmdadUnitPageEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadUnitEntity>> getById(int id) async {
    try {
      final result = await _dataSource.getById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadUnitEntity>> create(CreateEmdadUnitParamEntity param) async {
    try {
      final result = await _dataSource.create(param.toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadUnitEntity>> updateImage(UpdateEmdadUnitImageParamEntity param) async {
    try {
      final result = await _dataSource.updateImage(param.toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deleteById(int id) async {
    try {
      final result = await _dataSource.deleteById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<EmdadUnitPersonEntity>>> getPersons(int emdadUnitId) async {
    try {
      final request = EmdadUnitFilterRequestModel(
        filters: [
          EmdadUnitFilterModel(
            field: 'EmdadUnitId',
            value: emdadUnitId.toString(),
            operator: 'eq',
          ),
        ],
      );
      final result = await _dataSource.getPersons(request);
      return result.toApiResult<EmdadUnitPersonEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> assignPerson(AssignEmdadUnitPersonParamEntity param) async {
    try {
      final result = await _dataSource.assignPerson(param.toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deletePersonById(int id) async {
    try {
      final result = await _dataSource.deletePersonById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> changeLocation(ChangeEmdadUnitLocationParamEntity param) async {
    try {
      final result = await _dataSource.changeLocation(param.toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LookupEntity>>> getAgencies() async {
    try {
      final result = await _dataSource.getAgencies(const EmdadUnitFilterRequestModel(pageSize: 1000));
      return result.toApiResult<LookupEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LookupEntity>>> getAgencyPersons(int agencyInfoId) async {
    try {
      final result = await _dataSource.getAgencyPersons(_agencyFilterRequest(agencyInfoId));
      return result.toApiResult<LookupEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LookupEntity>>> getAgencyVehicles(int agencyInfoId) async {
    try {
      final result = await _dataSource.getAgencyVehicles(_agencyFilterRequest(agencyInfoId));
      return result.toApiResult<LookupEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LookupEntity>>> getActiveLocations() async {
    try {
      const request = EmdadUnitFilterRequestModel(
        pageSize: 1000,
        filters: [
          EmdadUnitFilterModel(
            field: 'isActive',
            value: 'true',
            operator: 'eq',
          ),
        ],
      );
      final result = await _dataSource.getLocations(request);
      return result.toApiResult<LookupEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  EmdadUnitFilterRequestModel _agencyFilterRequest(int agencyInfoId) {
    return EmdadUnitFilterRequestModel(
      pageSize: 1000,
      filters: [
        EmdadUnitFilterModel(
          field: 'AgencyInfoId',
          value: agencyInfoId.toString(),
          operator: 'eq',
        ),
      ],
    );
  }
}
