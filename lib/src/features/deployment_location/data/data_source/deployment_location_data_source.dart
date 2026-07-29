import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_page_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_id_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class DeploymentLocationDataSource {
  Future<BaseSingleResponse<DeploymentLocationPageModel>> getByFilter(
    DeploymentLocationFilterRequestModel request,
  );

  Future<BaseSingleResponse<DeploymentLocationModel>> getById(
    DeploymentLocationIdRequestModel request,
  );

  Future<BaseSingleResponse<String>> create(
    DeploymentLocationFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> update(
    DeploymentLocationFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> deleteById(
    DeploymentLocationIdRequestModel request,
  );
}
