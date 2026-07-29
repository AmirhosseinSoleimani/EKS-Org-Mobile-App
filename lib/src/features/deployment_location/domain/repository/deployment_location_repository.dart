import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class DeploymentLocationRepository {
  Future<ApiResult<DeploymentLocationPageEntity>> getByFilter(
    DeploymentLocationFilterParamEntity param,
  );

  Future<ApiResult<DeploymentLocationEntity>> getById(
    DeploymentLocationIdParamEntity param,
  );

  Future<ApiResult<String>> create(
    DeploymentLocationFormParamEntity param,
  );

  Future<ApiResult<String>> update(
    DeploymentLocationFormParamEntity param,
  );

  Future<ApiResult<String>> deleteById(
    DeploymentLocationIdParamEntity param,
  );
}
