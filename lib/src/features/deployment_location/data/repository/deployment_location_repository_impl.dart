import 'package:eks_sana_plus_org/src/features/deployment_location/data/data_source/deployment_location_data_source.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/repository/deployment_location_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeploymentLocationRepository)
class DeploymentLocationRepositoryImpl extends DeploymentLocationRepository {
  DeploymentLocationRepositoryImpl(this._dataSource);

  final DeploymentLocationDataSource _dataSource;

  @override
  Future<ApiResult<DeploymentLocationPageEntity>> getByFilter(
    DeploymentLocationFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(
        DeploymentLocationFilterRequestModel.fromParam(param),
      );
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<DeploymentLocationEntity>> getById(
    DeploymentLocationIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> create(
    DeploymentLocationFormParamEntity param,
  ) async {
    try {
      final result = await _dataSource.create(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> update(
    DeploymentLocationFormParamEntity param,
  ) async {
    try {
      final result = await _dataSource.update(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> deleteById(
    DeploymentLocationIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.deleteById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
