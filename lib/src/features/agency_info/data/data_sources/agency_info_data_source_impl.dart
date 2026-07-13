import 'package:eks_sana_plus_org/src/features/agency_info/data/data_sources/agency_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_page_model.dart';
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
}
