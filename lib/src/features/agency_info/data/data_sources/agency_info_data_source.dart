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
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class AgencyInfoDataSource {
  Future<AgencyInfoPageModel> getByFilter(AgencyInfoFilterRequestModel request);
  Future<BaseSingleResponse<AgencyInfoModel>> getById(int id);
  Future<BaseListResponse<AgencyInfoModel>> getByName(String title);

  Future<AgencyContractPageModel> getContracts(
    AgencyContractFilterRequestModel request,
  );

  Future<AgencyPersonPageModel> getCurrentPersons(
    AgencyInfoIdRequestModel request,
  );

  Future<PersonInfoSearchPageModel> searchPersons(
    PersonInfoSearchRequestModel request,
  );

  Future<AgencyVehiclePageModel> getCurrentVehicles(
    AgencyInfoIdRequestModel request,
  );

  Future<VehicleInfoSearchPageModel> searchVehicles(
    VehicleInfoSearchRequestModel request,
  );

  Future<void> changeStatus(ChangeAgencyStatusRequestModel request);

  Future<BaseSingleResponse<void>> deleteAgency(
    DeleteAgencyRequestModel request,
  );

  Future<BaseListResponse<AgencyServiceTypeModel>> getServiceTypes(
    AgencyIdRequestModel request,
  );

  Future<BaseSingleResponse<AgencyAdditionalInformationModel>>
  getAdditionalInformation(AgencyInfoIdRequestModel request);

  Future<BaseListResponse<AgencyHistoryModel>> getHistory(
    AgencyHistoryRequestModel request,
  );

  Future<AgencyInfoReportModel> getReport(AgencyInfoFilterRequestModel request);
}
