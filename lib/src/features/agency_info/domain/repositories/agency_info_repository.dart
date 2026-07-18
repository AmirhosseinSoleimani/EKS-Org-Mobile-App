import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_additional_information_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/change_agency_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/person_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/vehicle_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_page_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class AgencyInfoRepository {
  Future<ApiResult<AgencyInfoPageEntity>> getByFilter(
    AgencyInfoFilterParamEntity param,
  );

  Future<ApiResult<AgencyInfoEntity>> getById(int id);

  Future<ApiResult<List<AgencyInfoEntity>>> getByName(String title);

  Future<ApiResult<AgencyContractPageEntity>> getContracts(
    AgencyContractParamEntity param,
  );

  Future<ApiResult<AgencyPersonPageEntity>> getCurrentPersons(
    AgencyInfoIdParamEntity param,
  );

  Future<ApiResult<PersonInfoSearchPageEntity>> searchPersons(
    PersonInfoSearchParamEntity param,
  );

  Future<ApiResult<AgencyVehiclePageEntity>> getCurrentVehicles(
    AgencyInfoIdParamEntity param,
  );

  Future<ApiResult<VehicleInfoSearchPageEntity>> searchVehicles(
    VehicleInfoSearchParamEntity param,
  );

  Future<ApiResult<void>> changeStatus(ChangeAgencyStatusParamEntity param);

  Future<ApiResult<List<AgencyServiceTypeEntity>>> getServiceTypes(
    AgencyIdParamEntity param,
  );

  Future<ApiResult<AgencyAdditionalInformationEntity>> getAdditionalInformation(
    AgencyInfoIdParamEntity param,
  );

  Future<ApiResult<List<AgencyHistoryEntity>>> getHistory(
    AgencyHistoryParamEntity param,
  );
}
