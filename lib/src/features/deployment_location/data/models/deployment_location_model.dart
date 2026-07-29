import 'package:eks_sana_plus_org/src/features/deployment_location/data/models/deployment_location_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';

class DeploymentLocationModel extends DeploymentLocationEntity {
  const DeploymentLocationModel({
    super.id,
    super.title,
    super.address,
    super.latitude,
    super.longitude,
    super.cityId,
    super.cityTitle,
    super.provinceId,
    super.provinceTitle,
    super.isActive,
    super.insertFullName,
    super.insertDateTimeJalali,
    super.updateFullName,
  });

  factory DeploymentLocationModel.fromJson(Map<String, dynamic> json) {
    return DeploymentLocationModel(
      id: DeploymentLocationJsonHelper.integer(json['id'] ?? json['Id']),
      title: DeploymentLocationJsonHelper.string(
        json['title'] ?? json['Title'],
      ),
      address: DeploymentLocationJsonHelper.string(
        json['address'] ?? json['Address'],
      ),
      latitude: DeploymentLocationJsonHelper.decimal(
        json['latitude'] ?? json['Latitude'],
      ),
      longitude: DeploymentLocationJsonHelper.decimal(
        json['longitude'] ?? json['Longitude'],
      ),
      cityId: DeploymentLocationJsonHelper.integer(
        json['cityId'] ?? json['CityId'],
      ),
      cityTitle: DeploymentLocationJsonHelper.string(
        json['cityTitle'] ?? json['CityTitle'],
      ),
      provinceId: DeploymentLocationJsonHelper.integer(
        json['provinceId'] ?? json['ProvinceId'],
      ),
      provinceTitle: DeploymentLocationJsonHelper.string(
        json['provinceTitle'] ?? json['ProvinceTitle'],
      ),
      isActive: DeploymentLocationJsonHelper.boolean(
        json['isActive'] ?? json['IsActive'],
      ),
      insertFullName: DeploymentLocationJsonHelper.string(
        json['insertFullName'] ??
            json['InsertFullName'] ??
            json['insertUserFullName'] ??
            json['InsertUserFullName'],
      ),
      insertDateTimeJalali: DeploymentLocationJsonHelper.string(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      updateFullName: DeploymentLocationJsonHelper.string(
        json['updateFullName'] ?? json['UpdateFullName'],
      ),
    );
  }
}
