import 'package:eks_sana_plus_org/src/features/agency_info/data/data_sources/agency_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
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
}
