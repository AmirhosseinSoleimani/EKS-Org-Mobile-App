import 'package:eks_sana_plus_org/src/features/agency_info/data/data_sources/agency_info_data_source.dart';
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
import 'package:eks_sana_plus_org/src/features/agency_info/data/services/agency_info_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AgencyInfoDataSource)
class AgencyInfoDataSourceImpl extends AgencyInfoDataSource {
  AgencyInfoDataSourceImpl(this._service);

  final AgencyInfoService _service;

  @override
  Future<AgencyInfoPageModel> getByFilter(AgencyInfoFilterRequestModel request) {
    return _service.getByFilter(request);
  }

  @override
  Future<BaseSingleResponse<AgencyInfoModel>> getById(int id) {
    return _service.getById(id);
  }

  @override
  Future<BaseListResponse<AgencyInfoModel>> getByName(String title) {
    return _service.getByName(title);
  }

  @override
  Future<BaseSingleResponse<String>> addAgency(
    AddAgencyInfoRequestModel request,
  ) {
    return _service.addAgency(request);
  }

  @override
  Future<BaseSingleResponse<String>> addContract(
    AddAgencyContractRequestModel request,
  ) {
    return _service.addContract(request);
  }

  @override
  Future<BaseSingleResponse<AddAgencyPersonResponseModel>> addPerson(
    AddAgencyPersonRequestModel request,
  ) {
    return _service.addPerson(request);
  }

  @override
  Future<BaseSingleResponse<AddAgencyVehicleResponseModel>> addVehicle(
    AddAgencyVehicleRequestModel request,
  ) {
    return _service.addVehicle(request);
  }

  @override
  Future<AgencyContractPageModel> getContracts(
      AgencyContractFilterRequestModel request,) {
    return _service.getContracts(request);
  }

  @override
  Future<AgencyPersonPageModel> getCurrentPersons(
      AgencyInfoIdRequestModel request,) {
    return _service.getCurrentPersons(request);
  }

  @override
  Future<PersonInfoSearchPageModel> searchPersons(
      PersonInfoSearchRequestModel request,) {
    return _service.searchPersons(request);
  }

  @override
  Future<AgencyVehiclePageModel> getCurrentVehicles(
      AgencyInfoIdRequestModel request,) {
    return _service.getCurrentVehicles(request);
  }

  @override
  Future<VehicleInfoSearchPageModel> searchVehicles(
      VehicleInfoSearchRequestModel request,) {
    return _service.searchVehicles(request);
  }

  @override
  Future<void> changeStatus(ChangeAgencyStatusRequestModel request) {
    return _service.changeStatus(request);
  }

  @override
  Future<BaseSingleResponse<void>> deleteAgency(
    DeleteAgencyRequestModel request,
  ) {
    return _service.deleteAgency(request);
  }

  @override
  Future<BaseListResponse<AgencyServiceTypeModel>> getServiceTypes(
      AgencyIdRequestModel request,) {
    return _service.getServiceTypes(request);
  }

  @override
  Future<BaseSingleResponse<AgencyAdditionalInformationModel>>
  getAdditionalInformation(AgencyInfoIdRequestModel request) {
    return _service.getAdditionalInformation(request);
  }

  @override
  Future<BaseListResponse<AgencyHistoryModel>> getHistory(
      AgencyHistoryRequestModel request,) {
    return _service.getHistory(request);
  }

  @override
  Future<AgencyInfoReportModel> getReport(AgencyInfoFilterRequestModel request) {
    return _service.getReport(request);
  }
}
