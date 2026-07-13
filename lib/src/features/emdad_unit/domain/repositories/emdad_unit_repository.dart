import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/assign_emdad_unit_person_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/change_emdad_unit_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/create_emdad_unit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/update_emdad_unit_image_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class EmdadUnitRepository {
  Future<ApiResult<EmdadUnitPageEntity>> getByFilter(EmdadUnitFilterParamEntity param);
  Future<ApiResult<EmdadUnitEntity>> getById(int id);
  Future<ApiResult<EmdadUnitEntity>> create(CreateEmdadUnitParamEntity param);
  Future<ApiResult<EmdadUnitEntity>> updateImage(UpdateEmdadUnitImageParamEntity param);
  Future<ApiResult<void>> deleteById(int id);
  Future<ApiResult<List<EmdadUnitPersonEntity>>> getPersons(int emdadUnitId);
  Future<ApiResult<void>> assignPerson(AssignEmdadUnitPersonParamEntity param);
  Future<ApiResult<void>> deletePersonById(int id);
  Future<ApiResult<void>> changeLocation(ChangeEmdadUnitLocationParamEntity param);
  Future<ApiResult<List<LookupEntity>>> getAgencies();
  Future<ApiResult<List<LookupEntity>>> getAgencyPersons(int agencyInfoId);
  Future<ApiResult<List<LookupEntity>>> getAgencyVehicles(int agencyInfoId);
  Future<ApiResult<List<LookupEntity>>> getActiveLocations();
}
