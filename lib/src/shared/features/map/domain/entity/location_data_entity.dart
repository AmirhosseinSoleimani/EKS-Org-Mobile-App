import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_data_model.dart';

class LocationDataEntity {
  final int? id;
  final String? title;
  final String? type;
  final bool? hasTrafficPlan;
  final bool? hasPollutionPlan;
  final bool? hasTrafficOrPollutionPlan;
  final String? status;

  const LocationDataEntity({
    this.id,
    this.title,
    this.type,
    this.hasTrafficPlan,
    this.hasPollutionPlan,
    this.hasTrafficOrPollutionPlan,
    this.status,
  });

  LocationDataEntity copyWith({
    int? id,
    String? title,
    String? type,
    bool? hasTrafficPlan,
    bool? hasPollutionPlan,
    bool? hasTrafficOrPollutionPlan,
    String? status,
  }) {
    return LocationDataEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      hasTrafficPlan: hasTrafficPlan ?? this.hasTrafficPlan,
      hasPollutionPlan: hasPollutionPlan ?? this.hasPollutionPlan,
      hasTrafficOrPollutionPlan:
      hasTrafficOrPollutionPlan ?? this.hasTrafficOrPollutionPlan,
      status: status ?? this.status,
    );
  }

  LocationDataModel toModel() => LocationDataModel(
    id: id,
    title: title,
    type: type,
    hasTrafficPlan: hasTrafficPlan,
    hasPollutionPlan: hasPollutionPlan,
    hasTrafficOrPollutionPlan: hasTrafficOrPollutionPlan,
    status: status,
  );
}
