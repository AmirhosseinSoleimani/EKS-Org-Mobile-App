import 'package:eks_sana_plus_org/src/features/imei/data/data_source/imei_data_source.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_mutation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/repository/imei_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImeiRepository)
class ImeiRepositoryImpl extends ImeiRepository {
  ImeiRepositoryImpl(this._dataSource);

  final ImeiDataSource _dataSource;

  @override
  Future<ApiResult<ImeiInfoPageEntity>> getByFilter(
    ImeiInfoFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<DeviceInfoEntity>>> getDeviceTypes() async {
    try {
      final result = await _dataSource.getDeviceTypes();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ImeiInfoEntity>> getById(ImeiInfoIdParamEntity param) async {
    try {
      final result = await _dataSource.getById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> add(ImeiInfoMutationParamEntity param) async {
    try {
      final result = await _dataSource.add(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> update(ImeiInfoMutationParamEntity param) async {
    try {
      final result = await _dataSource.update(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> delete(ImeiInfoIdParamEntity param) async {
    try {
      final result = await _dataSource.delete(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
