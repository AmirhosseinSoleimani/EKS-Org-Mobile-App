import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class AgencyInfoDataSource {
  Future<AgencyInfoPageModel> getByFilter(AgencyInfoFilterRequestModel request);
  Future<BaseSingleResponse<AgencyInfoModel>> getById(int id);
  Future<BaseListResponse<AgencyInfoModel>> getByName(String title);
}
