import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class AgencyInfoRepository {
  Future<ApiResult<AgencyInfoPageEntity>> getByFilter(AgencyInfoFilterParamEntity param);
  Future<ApiResult<AgencyInfoEntity>> getById(int id);
  Future<ApiResult<List<AgencyInfoEntity>>> getByName(String title);
}
