import 'package:eks_sana_plus_org/src/features/agency_info/data/data_sources/agency_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_additional_information_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_contract_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/change_agency_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/delete_agency_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/person_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/vehicle_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AgencyInfoRepository)
class AgencyInfoRepositoryImpl extends AgencyInfoRepository {
  AgencyInfoRepositoryImpl(this._dataSource);

  final AgencyInfoDataSource _dataSource;

  @override
  Future<ApiResult<AgencyInfoPageEntity>> getByFilter(
    AgencyInfoFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AgencyInfoEntity>> getById(int id) async {
    try {
      final result = await _dataSource.getById(id);
      return result.toApiResult<AgencyInfoEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<AgencyInfoEntity>>> getByName(String title) async {
    try {
      final result = await _dataSource.getByName(title);
      return result.toApiResult<AgencyInfoEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<String>> addAgency(AddAgencyInfoParamEntity param) async {
    try {
      final result = await _dataSource.addAgency(param.toModel());
      return result.toApiResult<String>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AgencyContractPageEntity>> getContracts(
      AgencyContractParamEntity param,) async {
    try {
      final result = await _dataSource.getContracts(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AgencyPersonPageEntity>> getCurrentPersons(
      AgencyInfoIdParamEntity param,) async {
    try {
      final result = await _dataSource.getCurrentPersons(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<PersonInfoSearchPageEntity>> searchPersons(
      PersonInfoSearchParamEntity param,) async {
    try {
      final result = await _dataSource.searchPersons(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AgencyVehiclePageEntity>> getCurrentVehicles(
      AgencyInfoIdParamEntity param,) async {
    try {
      final result = await _dataSource.getCurrentVehicles(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<VehicleInfoSearchPageEntity>> searchVehicles(
      VehicleInfoSearchParamEntity param,) async {
    try {
      final result = await _dataSource.searchVehicles(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> changeStatus(
      ChangeAgencyStatusParamEntity param,) async {
    try {
      await _dataSource.changeStatus(param.toModel());
      return ApiResult.success(data: null, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> deleteAgency(DeleteAgencyParamEntity param) async {
    try {
      final result = await _dataSource.deleteAgency(param.toModel());
      return result.toApiResult<void>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<AgencyServiceTypeEntity>>> getServiceTypes(
      AgencyIdParamEntity param,) async {
    try {
      final result = await _dataSource.getServiceTypes(param.toModel());
      return result.toApiResult<AgencyServiceTypeEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AgencyAdditionalInformationEntity>>
  getAdditionalInformation(AgencyInfoIdParamEntity param) async {
    try {
      final result =
      await _dataSource.getAdditionalInformation(param.toModel());
      return result.toApiResult<AgencyAdditionalInformationEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<AgencyHistoryEntity>>> getHistory(
      AgencyHistoryParamEntity param,) async {
    try {
      final result = await _dataSource.getHistory(param.toModel());
      return result.toApiResult<AgencyHistoryEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<AgencyInfoReportEntity>> getReport(
      AgencyInfoFilterParamEntity param,
      ) async {
    try {
      final result = await _dataSource.getReport(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
