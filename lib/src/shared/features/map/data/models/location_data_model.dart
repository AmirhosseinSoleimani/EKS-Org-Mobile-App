import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_data_entity.dart';

class LocationDataModel extends LocationDataEntity {
  const LocationDataModel({
    super.id,
    super.title,
    super.type,
    super.hasTrafficPlan,
    super.hasPollutionPlan,
    super.hasTrafficOrPollutionPlan,
    super.status,
  });

  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()),
      title: json['title']?.toString(),
      type: json['type']?.toString(),
      hasTrafficPlan: json['hasTrafficPlan'] as bool?,
      hasPollutionPlan: json['hasPollutionPlan'] as bool?,
      hasTrafficOrPollutionPlan: json['hasTrafficOrPollutionPlan'] as bool?,
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'hasTraPlan': hasTrafficPlan,
      'hasPollutionPlan': hasPollutionPlan,
      'hasTrafficOrPollutionPlan': hasTrafficOrPollutionPlan,
      'status': status,
    };
  }
}
