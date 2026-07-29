import 'package:eks_sana_plus_org/src/features/deployment_location/data/data_source/deployment_location_data_source.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_page_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/data/service/deployment_location_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeploymentLocationDataSource)
class DeploymentLocationDataSourceImpl extends DeploymentLocationDataSource {
  DeploymentLocationDataSourceImpl(this._service);

  final DeploymentLocationService _service;

  @override
  Future<BaseSingleResponse<DeploymentLocationPageModel>> getByFilter(
    DeploymentLocationFilterRequestModel request,
  ) => _service.getByFilter(request);

  @override
  Future<BaseSingleResponse<DeploymentLocationModel>> getById(
    DeploymentLocationIdRequestModel request,
  ) => _service.getById(request);

  @override
  Future<BaseSingleResponse<String>> create(
    DeploymentLocationFormRequestModel request,
  ) => _service.create(request);

  @override
  Future<BaseSingleResponse<String>> update(
    DeploymentLocationFormRequestModel request,
  ) => _service.update(request);

  @override
  Future<BaseSingleResponse<String>> deleteById(
    DeploymentLocationIdRequestModel request,
  ) => _service.deleteById(request);
}
