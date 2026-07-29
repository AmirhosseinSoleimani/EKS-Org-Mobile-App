import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/params/deployment_location_form_request_model.dart';

class DeploymentLocationFormParamEntity {
  const DeploymentLocationFormParamEntity({
    this.id,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cityId,
    required this.isActive,
  });

  final int? id;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final int cityId;
  final bool isActive;

  DeploymentLocationFormRequestModel toModel() {
    return DeploymentLocationFormRequestModel(
      id: id,
      title: title,
      address: address,
      latitude: latitude,
      longitude: longitude,
      cityId: cityId,
      isActive: isActive,
    );
  }
}
